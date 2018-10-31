import Foundation
@testable import FlickrGallery

final class StubFlickrJsonLoader: FlickrJsonLoading {
    
    var stubData: Data?
    
    func loadImageFeedJson(completion: @escaping (Data?) -> Void) {
        completion(stubData)
    }    
}
