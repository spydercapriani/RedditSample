//
//  Constants.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/21/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import UIKit

internal enum TableConstants {
    static let SectionHeaderHeight: CGFloat = 25
    
    enum CellIdentifiers: String {
        case cell
    }
}

struct RedditURLS {
    static let redditBaseURL = "https://www.reddit.com/r/"
    
    enum Categories: String {
        case top = "Top"
        case new = "New"
        case hot = "Hot"
        case rising = "Rising"
        case controversial = "Controversial"
        
        static let allValues: [Categories] = [top, new, hot, rising, controversial]
    }
    
    
}
