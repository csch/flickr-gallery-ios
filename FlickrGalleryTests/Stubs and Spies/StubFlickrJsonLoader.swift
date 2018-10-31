import Foundation
@testable import FlickrGallery

final class StubJsonLoader: FlickrJsonLoading {        
    
    func loadImageFeedJson(completion: @escaping (Data) -> Void) {
        guard let jsonData = dataFromLocalFlickrJsonFile() else {
            fatalError("Could not load json file for testing")
        }
        completion(jsonData)
    }
    
    private func dataFromLocalFlickrJsonFile() -> Data? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Test", ofType: "json")!
        return NSData(contentsOfFile: path) as Data?
    }
}
