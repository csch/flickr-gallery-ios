import UIKit

protocol GalleryPresenting {
    func prepareData()
    
}

class GalleryPresenter: GalleryPresenting {
    
    weak var view: GalleryView?
    private let interactor: GalleryInteracting
    
    init(interactor: GalleryInteracting) {
        self.interactor = interactor
    }
    
    func prepareData() {
        interactor.provideRawImageMetadata { [weak self] (rawImageMetadata) in
            let imageMetadata = rawImageMetadata.compactMap({ImageMetadata(from: $0)})
            self?.view?.update(with: imageMetadata)
        }
    }
}

extension ImageMetadata {
    init?(from: RawImageMetadata) {
        self.init()
    }
}
