import XCTest
@testable import FlickrGallery

class GalleryViewControllerTests: XCTestCase {

    func test_viewDidLoad_letsPresenterPrepareData() {
        let viewController = GalleryViewController()
        let presenter = StubGalleryPresenter()
        viewController.presenter = presenter
        viewController.viewDidLoad()
        XCTAssertEqual(presenter.spyNumPrepareDataCalled, 1)
    }
}
