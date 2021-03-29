//
//  ImageChache.swift
//  LoginForm
//
//  Created by Lukas on 26.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    fileprivate let cache = NSCache<NSString, UIImage>()
    
    func set(key: String, image: UIImage) {
        DispatchQueue.main.sync {
            cache.setObject(image, forKey: key as NSString)
        }
    }
    
    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
