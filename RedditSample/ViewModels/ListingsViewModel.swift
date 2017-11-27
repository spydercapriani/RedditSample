//
//  ListingsViewModel.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/22/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import CleanroomLogger

class ListingsViewModel: ViewModel {
    
    // MARK: - Properties
    var listings: [RedditURLS.Categories: [RedditListing]] {
        return networkContainer?.redditData.redditListings ?? [
            .top: [],
            .new: [],
            .hot: [],
            .rising: [],
            .controversial: []
        ]
    }
    
    var subreddit: String = "Austin"
    
    func loadData(completionHandler: @escaping () -> Void) {
        networkContainer?.redditData.fetchSubreddit(for: self.subreddit, completionHandler: { (hasErrors, errors) in
            if hasErrors {
                Log.value(.error, value: errors)
            }
            Log.value(.debug, value: self.listings)
            completionHandler()
        })
    }
    
    // MARK: - Reddit Listing Data
    
    func getListing(for indexPath: IndexPath) -> (title: String?, link: String?) {
        let category = RedditURLS.Categories.allValues[indexPath.section]
        let listing: RedditListing? = listings[category]?[indexPath.row]
        return (listing?.title, listing?.link)
    }
}
