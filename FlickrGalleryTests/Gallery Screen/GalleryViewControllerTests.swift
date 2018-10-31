import XCTest
@testable import FlickrGallery

class GalleryViewControllerTests: XCTestCase {

    func test_viewDidLoad_letsPresenterPrepareData() {
        let viewController = GalleryViewController()
        let stubInteractor = StubGalleryInteractor()
        let presenter = StubGalleryPresenter(interactor: stubInteractor)
        viewController.presenter = presenter
        viewController.viewDidLoad()
        XCTAssertEqual(presenter.spyNumPrepareDataCalled, 1)
    }
}
