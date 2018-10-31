import UIKit
@testable import FlickrGallery

final class StubAppCoordinator: AppCoordinating {
    
    var spyNumShowGalleryScreenCalled = 0
    
    func showGalleryScreen(on navigationController: UINavigationController) {
        spyNumShowGalleryScreenCalled += 1
    }
}
