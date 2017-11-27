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
    var redditListings: [RedditURLS.Categories: [RedditListing]] = [
        .top: [],
        .new: [],
        .hot: [],
        .rising: [],
        .controversial: []
    ]
    
    func fetchSubreddit(for subreddit: String, completionHandler: @escaping (Bool, [RedditURLS.Categories: Error?]) -> ()) {
        let url = RedditURLS.redditBaseURL + subreddit
        var containsErrors = false
        var errorList: [RedditURLS.Categories: Error?] = [
            .top: nil,
            .new: nil,
            .hot: nil,
            .rising: nil,
            .controversial: nil
        ]
        
        let redditRequests = DispatchGroup()
        for category in RedditURLS.Categories.allValues {
            redditRequests.enter()
            fetchRedditLinks(for: url, category: category, completionHandler: { (categoryList, error) in
                if let categoryError = error {
                    errorList[category]? = categoryError
                    containsErrors = true
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
    
    private func fetchRedditLinks(for url: String, category: RedditURLS.Categories, completionHandler: @escaping ([RedditListing], Error?) -> ()) {
        var listings: [RedditListing] = []
        let jsonURL = "\(url)/\(category.rawValue.lowercased()).json"
        Log.message(.info, message: "Fetching links for \(category.rawValue)")
        Alamofire.request(jsonURL).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for child in json["data"]["children"].arrayValue {
                    let title = child["data"]["title"].stringValue
                    let link = "https://www.reddit.com" + child["data"]["permalink"].stringValue
                    let listing = RedditListing(title: title, link: link)
                    Log.message(.verbose, message: "\(category.rawValue): \(title) - \(link)\n")
                    listings.append(listing)
                }
                completionHandler(listings, nil)
            case .failure(let error):
                completionHandler(listings, error)
            }
        })
        
    }
}
