import XCTest
@testable import FlickrGallery

class AppCoordinatorTests: XCTestCase {
    
    func test_showGalleryScreen_putsGalleryViewControllerOnStack() {
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator()
        appCoordinator.showGalleryScreen(on: navigationController)
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        let viewController = navigationController.viewControllers.first as? GalleryViewController
        XCTAssertNotNil(viewController)
    }
}
