import UIKit
@testable import FlickrGallery

final class StubAppCoordinator: AppCoordinator {
    
    var spyNumShowGalleryScreenCalled = 0
    
    override func showGalleryScreen(on navigationController: UINavigationController) {
        spyNumShowGalleryScreenCalled += 1
    }
}
