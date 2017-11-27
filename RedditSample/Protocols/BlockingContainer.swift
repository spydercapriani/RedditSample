//
//  BlockingContainer.swift
//  RedditSample
//
//  Created by Daniel Gilbert on 11/27/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import UIKit

public protocol canBlockView {
    var view: UIView! { get set }
    func blockUI()
    func unblockUI()
}

public extension canBlockView {
    func blockUI() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        let blockingView = UIView(frame: .zero)
        
        blockingView.tag = 100
        activityIndicator.tag = 101
        
        blockingView.backgroundColor = .black
        blockingView.alpha = CGFloat(0.35)
        
        activityIndicator.color = .white
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        blockingView.translatesAutoresizingMaskIntoConstraints = false
        
        blockingView.addSubview(activityIndicator)
        view.addSubview(blockingView)
        
        NSLayoutConstraint.activate(
            constraints(for: activityIndicator, on: blockingView) +
                constraints(for: blockingView)
        )
        
        activityIndicator.startAnimating()
    }
    
    func unblockUI() {
        if let blockingView = self.view.viewWithTag(100), let activityIndicator = self.view.viewWithTag(101){
            blockingView.removeFromSuperview()
            activityIndicator.removeFromSuperview()
        }
    }
    
    private func constraints(for indicator: UIActivityIndicatorView, on blockingView: UIView) -> [NSLayoutConstraint] {
        return [
            indicator.centerXAnchor.constraint(equalTo: blockingView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: blockingView.centerYAnchor)
        ]
    }
    
    private func constraints(for blockingView: UIView) -> [NSLayoutConstraint] {
        return [
            blockingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            blockingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            blockingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            blockingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ]
    }
}
