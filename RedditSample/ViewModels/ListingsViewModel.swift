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
    var listings: [String: [RedditListing]] {
        return dataContainer?.data ?? ["nil": []]
    }
    
    // MARK: - Reddit Listing Data
    
    func getListing(for list: TableSection, at indexPath: IndexPath) -> (title: String?, link: String?) {
        let listing: RedditListing? = listings[list.title()]?[indexPath.row]
        return (listing?.title, listing?.link)
    }
}
