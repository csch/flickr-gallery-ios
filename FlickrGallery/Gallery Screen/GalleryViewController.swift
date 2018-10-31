import UIKit

protocol GalleryView: class {
    func update(with imageMetadata: [ImageMetadata])
}

class GalleryViewController: UIViewController, GalleryView {
    
    var presenter: GalleryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.prepareData()
    }
    
    func update(with: [ImageMetadata]) {
        
    }
}

