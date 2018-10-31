import XCTest
@testable import FlickrGallery

class StubGalleryView: GalleryView {

    var spyNumUpdateCalled = 0
    var spyImageMetadata: [ImageMetadata]?
    
    func update(with imageMetadata: [ImageMetadata]) {
        spyNumUpdateCalled += 1
        spyImageMetadata = imageMetadata
    }
}
