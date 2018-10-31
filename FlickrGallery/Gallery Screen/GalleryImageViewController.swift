import UIKit

class GalleryImageViewController: UIViewController {

    static func from(storyboard: UIStoryboard) -> GalleryImageViewController? {
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? GalleryImageViewController
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var onViewDidLoad: ((GalleryImageViewController) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?(self)
    }
}
