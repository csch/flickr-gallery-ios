import XCTest
@testable import FlickrGallery

class GalleryInteractorTests: XCTestCase {

    private var interactor: GalleryInteractor!
    
    override func setUp() {
        super.setUp()
        let jsonLoader = StubJsonLoader()
        interactor = GalleryInteractor(jsonLoader: jsonLoader)
    }
    
    override func tearDown() {
        interactor = nil
        super.tearDown()
    }
    
    func test_provideRawImageMetadata_returns20MetadataItems() {
        var receivedImageMetadataArray: [RawImageMetadata] = []
        interactor.provideRawImageMetadata { (imageMetadataArray) in
            receivedImageMetadataArray = imageMetadataArray
        }
        XCTAssertEqual(receivedImageMetadataArray.count, 20)
    }
    
    func test_provideRawImageMetadata_firstImageMetadataHasCorrectValues() {
        var firstImageMetadata: RawImageMetadata?
        interactor.provideRawImageMetadata { (imageMetadataArray) in
            firstImageMetadata = imageMetadataArray.first
        }
        XCTAssertEqual(firstImageMetadata?.title, "IMG_5446")
        XCTAssertEqual(firstImageMetadata?.link, "https://www.flickr.com/photos/75433030@N02/30706031327/")
        XCTAssertEqual(firstImageMetadata?.media?.m, "https://farm2.staticflickr.com/1925/30706031327_a574b49691_m.jpg")
        XCTAssertEqual(firstImageMetadata?.date_taken, "2018-10-30T14:31:52-08:00")
        XCTAssertEqual(firstImageMetadata?.description, " <p><a href=\"https://www.flickr.com/people/75433030@N02/\">MarcusDC</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/75433030@N02/30706031327/\" title=\"IMG_5446\"><img src=\"https://farm2.staticflickr.com/1925/30706031327_a574b49691_m.jpg\" width=\"240\" height=\"160\" alt=\"IMG_5446\" /></a></p> ")
        XCTAssertEqual(firstImageMetadata?.published, "2018-10-31T10:15:59Z")
        XCTAssertEqual(firstImageMetadata?.author, "nobody@flickr.com (\"MarcusDC\")")
        XCTAssertEqual(firstImageMetadata?.tags, "")
    }
}
