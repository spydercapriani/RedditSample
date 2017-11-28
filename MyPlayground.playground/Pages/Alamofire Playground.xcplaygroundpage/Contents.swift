//: Playground - noun: a place where people can play

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

let url = "https://www.reddit.com/r/Austin/top.json"

let request = Alamofire.request(url).responseJSON(completionHandler: { (response) in
    switch response.result {
    case .success(let value):
        let json = JSON(value)
        for child in json["data"]["children"].arrayValue {
            let title = child["data"]["title"].stringValue
            let link = "https://www.reddit.com" + child["data"]["permalink"].stringValue
            var thumbnail = child["data"]["thumbnail"].string
            if thumbnail == "self" {
                thumbnail = nil
            }
            print("\(title)\n\(link)\n\(thumbnail)\n")
        }
    case .failure(let error):
        print(error)
    }
})
//debugPrint(request)

