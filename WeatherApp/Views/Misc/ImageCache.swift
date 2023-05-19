//
//  ImageCache.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/17/23.
//

import Foundation

class ImageCache {
    static var shared = ImageCache()
    var cache = NSCache<NSString, NSData>()
    
    init() {
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
    }
    
    func get(for key: String) -> Data? {
        return cache.object(forKey: NSString(string: key)) as? Data
    }
    
    func set(for key: String, data: NSData) {
        cache.setObject(data, forKey: NSString(string: key))
    }
}
