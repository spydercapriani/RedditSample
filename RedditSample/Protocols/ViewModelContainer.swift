//
//  ViewModelContainer.swift
//  RedditSample
//
//  Created by Danny Gilbert on 11/22/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation

protocol ViewModelContainer {
    associatedtype VM: ViewModel
    
    var viewModel: VM { get set }
}
