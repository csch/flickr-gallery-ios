import UIKit

protocol AsyncImage {
    func fetchImage(completion: @escaping (UIImage) -> Void)
}

struct URLFetchedAsyncImage: AsyncImage {
    
    private let url: URL
    private let session: URLSession
    private let dispatcher: Dispatching
    
    init(url: URL, session: URLSession, dispatcher: Dispatching) {
        self.url = url
        self.session = session
        self.dispatcher = dispatcher
    }
    
    func fetchImage(completion: @escaping (UIImage) -> Void) {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            self.dispatcher.dispatchAsyncOnMain {
                completion(image)
            }
        }
        task.resume()
    }
}
