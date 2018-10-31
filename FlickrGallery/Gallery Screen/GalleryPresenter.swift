import UIKit

protocol GalleryPresenting {
    var view: GalleryView? { get }
    func prepareData()
}

class GalleryPresenter: GalleryPresenting {
    
    weak var view: GalleryView?
    private let interactor: GalleryInteracting
    
    init(interactor: GalleryInteracting) {
        self.interactor = interactor
    }
    
    func prepareData() {
        let dateFormatter = DateFormatter()
        interactor.provideRawImageMetadata { [weak self] (rawImageMetadata) in
            let imageMetadata = rawImageMetadata.compactMap({ImageMetadata(from: $0, dateFormatter: dateFormatter)})
            self?.view?.update(with: imageMetadata)
        }
    }
}

extension ImageMetadata {
    
    static func convert(dateTakenString: String?, with dateFormatter: DateFormatter) -> String? {
        guard let string = dateTakenString else { return nil }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: string) else { return nil }
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    init?(from raw: RawImageMetadata, dateFormatter: DateFormatter) {
        guard let imageUrlString = raw.media?.m,
            let url = URL(string: imageUrlString) else { return nil }
        
        let asyncImage = URLFetchedAsyncImage(url: url, session: URLSession.shared, dispatcher: Dispatcher())
        let dateTakenString = ImageMetadata.convert(dateTakenString: raw.date_taken, with: dateFormatter)
        self.init(asyncImage: asyncImage, title: raw.title, dateTakenString: dateTakenString)
    }
}
