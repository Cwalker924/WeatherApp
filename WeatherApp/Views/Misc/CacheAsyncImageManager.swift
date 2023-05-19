//
//  CacheAsyncImageManager.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/17/23.
//

import SwiftUI

class CacheAsyncImageManager: ObservableObject {
    let cache = ImageCache.shared
    
    enum State { case loading, failed (Error), success(data: Data) }
    @Published var state: State?
    
    @MainActor
    func imageLoad(url: URL, cache: ImageCache = .shared) async {
        state = .loading
        // get cached image if possible
        if let data = cache.get(for: url.absoluteString) {
            state = .success(data: data)
            return
        }
        
        do {
            let data = try await HTTPClient.shared.get(url: url)
            state = .success(data: data)
            // save cache image
            cache.set(for: url.absoluteString, data: data as NSData)
        } catch {
            state = .failed(error)
        }
    }
}
