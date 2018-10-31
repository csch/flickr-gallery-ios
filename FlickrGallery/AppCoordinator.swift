import UIKit

protocol AppCoordinating {
    func showGalleryScreen(on navigationController: UINavigationController)
}

class AppCoordinator: AppCoordinating {
    
    func showGalleryScreen(on navigationController: UINavigationController) {
        navigationController.setViewControllers([GalleryViewController()], animated: false)
    }
}
