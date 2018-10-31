import UIKit

protocol AppCoordinating {
    func showGalleryScreen(on navigationController: UINavigationController)
}

class AppCoordinator: AppCoordinating {
    
    private func makePresenter() -> GalleryPresenter {
        let jsonLoader = FlickrJsonLoader(urlSession: URLSession.shared, dispatcher: Dispatcher())
        let interactor = GalleryInteractor(jsonLoader: jsonLoader)
        return GalleryPresenter(interactor: interactor)
    }
    
    func showGalleryScreen(on navigationController: UINavigationController) {
        let viewController = GalleryViewController()
        let presenter = makePresenter()
        presenter.view = viewController
        viewController.presenter = presenter
        navigationController.setViewControllers([viewController], animated: false)
    }
}
