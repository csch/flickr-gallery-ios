import Foundation
@testable import FlickrGallery

final class StubGalleryInteractor: GalleryInteracting {
    
    var spyNumProvideRawImageMetadataCalled = 0
    var stubImageMetadata = [RawImageMetadata]()
    
    func provideRawImageMetadata(completion: @escaping ([RawImageMetadata]) -> Void) {
        completion(stubImageMetadata)
        spyNumProvideRawImageMetadataCalled += 1
    }
}
