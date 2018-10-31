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
    
    func test_prepareData_noData_updatesView() {
        stubInteractor.stubImageMetadata = []
        presenter.prepareData()
        XCTAssertEqual(stubView.spyNumUpdateCalled, 1)
        XCTAssertEqual(stubView.spyImageMetadata?.count, 0)
    }
    
    func test_prepareData_invalidData_updatesViewWithNoData() {
        let rawImageMetadata = RawImageMetadata(title: nil, link: nil, media: nil,
                                                date_taken: nil, description: nil,
                                                published: nil, author: nil, tags: nil)
        stubInteractor.stubImageMetadata = [rawImageMetadata]
        presenter.prepareData()
        XCTAssertEqual(stubView.spyNumUpdateCalled, 1)
        XCTAssertEqual(stubView.spyImageMetadata?.count, 0)
    }
    
    func test_prepareData_validData_updatesViewWithCorrectData() {
        let media = RawImageMetadata.Media(m: "https://url.com")
        let rawImageMetadata = RawImageMetadata(title: "Title", link: nil, media: media,
                                                date_taken: "2018-10-31T10:15:59Z", description: nil,
                                                published: nil, author: nil, tags: nil)
        stubInteractor.stubImageMetadata = [rawImageMetadata]
        presenter.prepareData()
        let imageMetadata = stubView.spyImageMetadata?.first
        XCTAssertEqual(imageMetadata?.title, "Title")
        XCTAssertEqual(imageMetadata?.dateTakenString, "Oct 31, 2018 at 10:15 AM")
        XCTAssertNotNil(imageMetadata?.asyncImage)
    }
    
    func test_prepareData_invalidDateTakenString_updatesViewWithDataMissingDateTaken() {
        let media = RawImageMetadata.Media(m: "https://url.com")
        let rawImageMetadata = RawImageMetadata(title: nil, link: nil, media: media,
                                                date_taken: "2018-10-31 10:15:59", description: nil,
                                                published: nil, author: nil, tags: nil)
        stubInteractor.stubImageMetadata = [rawImageMetadata]
        presenter.prepareData()
        let imageMetadata = stubView.spyImageMetadata?.first
        XCTAssertEqual(imageMetadata?.dateTakenString, nil)
        XCTAssertNotNil(imageMetadata?.asyncImage)
    }
}
