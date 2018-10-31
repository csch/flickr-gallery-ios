import XCTest
@testable import FlickrGallery

class StubGalleryPresenter: GalleryPresenting {
    
    var view: GalleryView?    

    var spyNumPrepareDataCalled = 0
    
    func prepareData() {
        spyNumPrepareDataCalled += 1
    }
}
