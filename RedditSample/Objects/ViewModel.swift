//
//  ViewModel.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/22/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import UIKit

class ViewModel {
    
    // MARK: - Properties
    var placeholderContainer: PlaceholderDataContainer?
    var dataContainer: DataContainer? {
        return placeholderContainer?.container
    }
    
    // MARK: - Initializer
    init(placeholderContainer: PlaceholderDataContainer? = UIApplication.shared.delegate as? AppDelegate) {
        self.placeholderContainer = placeholderContainer
    }
}
