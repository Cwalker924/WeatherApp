//
//  CachedImageView.swift
//  WeatherApp
//
//  Created by Colton Walker on 5/17/23.
//

import SwiftUI

/// CachedImageView is an asyncImage remake w/ custom caching policy
struct CachedImageView<Content: View>: View {
    @StateObject var cashedImageManager = CacheAsyncImageManager()
    let url: URL
    @ViewBuilder var content:(AsyncImagePhase) -> (Content)
    
    var body: some View {
        ZStack {
            switch cashedImageManager.state {
            case .failed(let error): content(.failure(error))
            case .loading: content(.empty)
            case .success(let data):
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    content(.success(image))
                } else {
                    content(.failure(ImageCacheError.badData))
                }
            default:
                content(.empty)
            }
        }
        .task {
            await cashedImageManager.imageLoad(url: url)
        }
    }
}

struct CachedImageView_Previews: PreviewProvider {
    static var previews: some View {
        CachedImageView(url: URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!) { phase in
            switch phase {
            case .success(let image):
                image
                    .frame(width: 100, height: 100)
            case .empty:
                Image(systemName: "person")
                    .frame(width: 100, height: 100)
            case .failure(let error):
                Text(error.localizedDescription)
                    .font(.system(size: 20).bold())
                    .foregroundColor(.gray)
            default:
                Image(systemName: "person")
                    .frame(width: 100, height: 100)
            }
        }
    }
}

extension CachedImageView {
    enum ImageCacheError: Error {
        case badData
    }
}
