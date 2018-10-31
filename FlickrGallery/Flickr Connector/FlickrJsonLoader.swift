import Foundation

protocol FlickrJsonLoading {
    func loadImageFeedJson(completion: @escaping (Data) -> Void)
}

final class FlickrJsonLoader: FlickrJsonLoading {
    
    func loadImageFeedJson(completion: @escaping (Data) -> Void) {
    }
}
