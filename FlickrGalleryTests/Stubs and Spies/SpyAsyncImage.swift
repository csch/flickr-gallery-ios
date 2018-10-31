import UIKit
@testable import FlickrGallery

class SpyAsyncImage: AsyncImage {
    let url: URL
    var fetchImageCalled = 0
    
    init(url: URL) {
        self.url = url
    }
    
    func fetchImage(completion: @escaping (UIImage) -> Void) {
        fetchImageCalled += 1
    }
}
