import Foundation

struct RawImageMetadata: Decodable {
    
    struct Media: Decodable {
        let m: String?
    }
    
    let title: String?
    let link: String?
    let media: Media?
    let date_taken: String?
    let description: String?
    let published: String?
    let author: String?
    let tags: String?
}

struct ImageMetadata {
    
}
