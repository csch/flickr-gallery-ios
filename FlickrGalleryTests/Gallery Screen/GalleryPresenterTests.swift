import XCTest
@testable import FlickrGallery

class GalleryPresenterTests: XCTestCase {

    var presenter: GalleryPresenter!
    var stubView: StubGalleryView!
    var stubInteractor: StubGalleryInteractor!
    
    override func setUp() {
        super.setUp()
        stubView = StubGalleryView()
        stubInteractor = StubGalleryInteractor()
        presenter = GalleryPresenter(interactor: stubInteractor)
        presenter.view = stubView
    }
    
    override func tearDown() {
        presenter = nil
        stubInteractor = nil
        super.tearDown()
    }
    
    func test_prepareData_pullsDataFromInteractor() {
        presenter.prepareData()
        XCTAssertEqual(stubInteractor.spyNumProvideRawImageMetadataCalled, 1)
    }
    
    func test_prepareData_updatesViewWithTransformedData() {
        let media = RawImageMetadata.Media(m: "https://url.com")
        let rawImageMetadata = RawImageMetadata(title: nil, link: nil, media: media,
                                                date_taken: nil, description: nil,
                                                published: nil, author: nil, tags: nil)
        stubInteractor.stubImageMetadata = [rawImageMetadata]
        presenter.prepareData()
        XCTAssertEqual(stubView.spyNumUpdateCalled, 1)
        XCTAssertEqual(stubView.spyImageMetadata?.count, 1)
    }
}
