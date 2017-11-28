//: [Previous](@previous)

import Foundation
import Alamofire
import AlamofireImage
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

var imageURL = "https://b.thumbs.redditmedia.com/13ablndmRA_Fu1QitXt29fBvhiQoEW6XGGIn_oMezRM.jpg"

Alamofire.request(imageURL).responseImage { (response) in
    debugPrint(response)

    if let image = response.result.value {
        print("image downloaded: \(image)")
        image
    }
}

//: [Next](@next)
