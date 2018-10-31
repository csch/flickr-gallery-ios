import XCTest
@testable import FlickrGallery

class AppCoordinatorTests: XCTestCase {
    
    private func showGalleryScreen() -> GalleryViewController? {
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator()
        appCoordinator.showGalleryScreen(on: navigationController)
        return navigationController.viewControllers.first as? GalleryViewController
    }
    
    func test_showGalleryScreen_putsGalleryViewControllerOnStack() {
        let viewController = showGalleryScreen()
        XCTAssertNotNil(viewController)
    }
    
    func test_showGalleryScreen_viewControllerHasPresenter() {
        let viewController = showGalleryScreen()
        XCTAssertNotNil(viewController?.presenter)
    }
    
    func test_showGalleryScreen_presenterHasView() {
        let viewController = showGalleryScreen()
        XCTAssertEqual(viewController?.presenter?.view as? GalleryViewController, viewController)
    }
}
