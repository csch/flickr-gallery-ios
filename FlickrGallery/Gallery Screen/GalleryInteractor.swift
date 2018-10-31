import Foundation

protocol GalleryInteracting {
    func provideRawImageMetadata(completion: @escaping ([RawImageMetadata]) -> Void)
}

final class GalleryInteractor: GalleryInteracting {
  
    private let jsonLoader: FlickrJsonLoading
    
    init(jsonLoader: FlickrJsonLoading) {
        self.jsonLoader = jsonLoader
    }
    
    func provideRawImageMetadata(completion: @escaping ([RawImageMetadata]) -> Void) {
        jsonLoader.loadImageFeedJson { [weak self] data in
            guard let data = data else {
                completion([])
                return
            }
            let imageMetadata = self?.provideRawImageMetadata(fromJson: data) ?? []
            completion(imageMetadata)
        }
    }
    
    private func provideRawImageMetadata(fromJson data: Data) -> [RawImageMetadata] {
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        guard let items = jsonDictionary?["items"] as? [[String: Any]] else { return [] }
        let jsonDecoder = JSONDecoder()
        let parsedRawImageMetadata: [RawImageMetadata] = items.compactMap({ dict in
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else {
                return nil
            }
            return try? jsonDecoder.decode(RawImageMetadata.self, from: data)
        })
        return parsedRawImageMetadata
    }
}
