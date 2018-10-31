import UIKit
@testable import FlickrGallery

final class SpyAndStubAppCoordinator: AppCoordinator {
    
    var spyNumShowGalleryScreenCalled = 0
    
    override func showGalleryScreen(on navigationController: UINavigationController) {
        spyNumShowGalleryScreenCalled += 1
    }
}
