//
//  Network.swift
//  RedditSample
//
//  Created by Daniel Gilbert on 11/27/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CleanroomLogger

protocol RedditDataContainer {
    var redditData: RedditData { get set }
}

class RedditData {
    var redditListings: [RedditConstants.Categories: [RedditListing]] = [
        .top: [],
        .new: [],
        .hot: [],
        .rising: [],
        .controversial: []
    ]
    
    /// Performs fetch for all categories of a given Subreddit
    ///
    /// - Parameters:
    ///   - subreddit: Subreddit Name
    ///   - completionHandler: Returns error check bool and error list from network calls
    func fetchSubreddit(for subreddit: String, completionHandler: @escaping (Bool, [RedditConstants.Categories: Error?]) -> ()) {
        Log.message(.info, message: "Fetching links for Subreddit /r/\(subreddit)")
        let url = RedditConstants.redditBaseURL + subreddit
        var containsErrors = false
        var errorList: [RedditConstants.Categories: Error?] = [
            .top: nil,
            .new: nil,
            .hot: nil,
            .rising: nil,
            .controversial: nil
        ]
        
        let redditRequests = DispatchGroup()
        for category in RedditConstants.Categories.allValues {
            redditRequests.enter()
            fetchRedditLinks(for: url, category: category, completionHandler: { (categoryList, error) in
                if let categoryError = error {
                    errorList[category]? = categoryError
                    containsErrors = true
                    Log.value(.error, value: categoryError)
                }
                
                self.redditListings[category] = categoryList
                Log.value(.verbose, value: self.redditListings[category])
                redditRequests.leave()
            })
        }
        
        redditRequests.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            Log.value(.verbose, value: self.redditListings)
            completionHandler(containsErrors, errorList)
        }))
    }
    
    /// Performs network call to specified URL for a given category.
    /// Receives & parses returning JSON. Turning it into an instance
    /// of RedditListing.
    ///
    /// - Parameters:
    ///   - url: Subreddit URL
    ///   - category: Subreddit Category
    ///   - completionHandler: Returns array of Reddit Listings or an Error
    private func fetchRedditLinks(for url: String, category: RedditConstants.Categories, completionHandler: @escaping ([RedditListing], Error?) -> ()) {
        var listings: [RedditListing] = []
        let jsonURL = "\(url)/\(category.rawValue.lowercased()).json"
        Log.message(.info, message: "Fetching links for \(category.rawValue)")
        Alamofire.request(jsonURL).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for child in json["data"]["children"].arrayValue {
                    let title = child["data"]["title"].stringValue.html2String
                    let link = "https://www.reddit.com" + child["data"]["permalink"].stringValue
                    var thumbnail = child["data"]["thumbnail"].string
                    if thumbnail == "self" {
                        thumbnail = nil
                    }
                    let listing = RedditListing(title: title, link: link, thumbnail: thumbnail)
                    Log.message(.verbose, message: "\(category.rawValue): \(title) - \(link) - \(thumbnail ?? "")\n")
                    Log.message(.verbose, message: "Title: \(title)")
                    Log.message(.verbose, message: "Link: \(link)")
                    Log.message(.verbose, message: "Thumbnail: \(thumbnail ?? "none")")
                    listings.append(listing)
                }
                completionHandler(listings, nil)
            case .failure(let error):
                completionHandler(listings, error)
            }
        })
        
    }
}
