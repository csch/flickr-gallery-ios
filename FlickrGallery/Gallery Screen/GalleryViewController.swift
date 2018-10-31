import UIKit

protocol GalleryView: class {
    func update(with imageMetadata: [ImageMetadata])
}

class GalleryViewController: UIPageViewController, UIPageViewControllerDataSource, GalleryView {
    
    var presenter: GalleryPresenting?
    private var imageViewControllers = [UIViewController]()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.prepareData()
        dataSource = self
    }
    
    func update(with imageMetadata: [ImageMetadata]) {
        imageViewControllers = imageMetadata.compactMap({makeImageViewController(with: $0)})
        if let first = imageViewControllers.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func makeImageViewController(with imageMetadata: ImageMetadata) -> GalleryImageViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = GalleryImageViewController.from(storyboard: storyboard) else { return nil }
        
        vc.onViewDidLoad = { vc in
            vc.titleLabel.text = imageMetadata.title ?? ""
            vc.dateLabel.text = imageMetadata.dateTakenString ?? ""
            imageMetadata.asyncImage.fetchImage { (image) in
                vc.imageView.image = image
            }
        }        
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = imageViewControllers.firstIndex(of: viewController) else { return nil }
        let vc = imageViewControllers[safe: index - 1]
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = imageViewControllers.firstIndex(of: viewController) else { return nil }
        let vc = imageViewControllers[safe: index + 1]
        return vc
    }
}

