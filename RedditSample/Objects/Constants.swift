//
//  Constants.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/21/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import UIKit



internal enum CellIdentifier: String {
    case cell
}

internal enum TableSection: Int {
    case top = 0
    case new = 1
    case rising = 2
    case hot = 3
    case controversial = 4
    
    static let allValues: [TableSection] = [
        .top,
        .new,
        .rising,
        .hot,
        .controversial
    ]
    
    static let SectionHeaderHeight: CGFloat = 25
    
    func title() -> String {
        switch self {
            case .top: return "Top"
            case .new: return "New"
            case .hot: return "Hot"
            case .rising: return "Rising"
            case .controversial: return "Controversial"
        }
    }
}
