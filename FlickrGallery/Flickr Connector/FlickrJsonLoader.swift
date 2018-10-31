import Foundation

protocol FlickrJsonLoading {
    func loadImageFeedJson(completion: @escaping (Data?) -> Void)
}

final class FlickrJsonLoader: FlickrJsonLoading {
    
    private let urlSession: URLSession
    private let dispatcher: Dispatching
    
    init(urlSession: URLSession, dispatcher: Dispatching) {
        self.urlSession = urlSession
        self.dispatcher = dispatcher
    }
    
    func loadImageFeedJson(completion: @escaping (Data?) -> Void) {
        let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=Southwark")!
        let task = urlSession.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            self?.dispatcher.dispatchAsyncOnMain {
                completion(data)
            }
        })
        task.resume()
    }
}
