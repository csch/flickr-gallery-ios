import XCTest
@testable import FlickrGallery

class StubGalleryPresenter: GalleryPresenter {

    var spyNumPrepareDataCalled = 0
    
    override func prepareData() {
        spyNumPrepareDataCalled += 1
    }
}
