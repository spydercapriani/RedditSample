//
//  Extension+String.swift
//  RedditSample
//
//  Created by Daniel Gilbert on 11/28/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import Foundation
import UIKit
import CleanroomLogger

extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            Log.message(.error, message: "HTML2Attributed String Error: \(error)")
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
