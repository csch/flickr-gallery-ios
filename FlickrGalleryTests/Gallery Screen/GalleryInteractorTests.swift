import XCTest
@testable import FlickrGallery

class GalleryInteractorTests: XCTestCase {

    private var stubJsonLoader: StubJsonLoader!
    private var interactor: GalleryInteractor!
    
    override func setUp() {
        super.setUp()
        stubJsonLoader = StubJsonLoader()
        interactor = GalleryInteractor(jsonLoader: stubJsonLoader)
    }
    
    override func tearDown() {
        stubJsonLoader = nil
        interactor = nil
        super.tearDown()
    }
    
    var dataFromLocalFlickrJsonFile: Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Test", ofType: "json")!
        guard let jsonData = NSData(contentsOfFile: path) else {
            fatalError("Could not load json file for testing")
        }
        return jsonData as Data
    }
    
    func test_provideRawImageMetadata_noData_returnsEmptyMetadataItems() {
        stubJsonLoader.stubData = nil
        var receivedImageMetadataArray: [RawImageMetadata] = []
        interactor.provideRawImageMetadata { (imageMetadataArray) in
            receivedImageMetadataArray = imageMetadataArray
        }
        XCTAssertEqual(receivedImageMetadataArray.count, 0)
    }
    
    func test_provideRawImageMetadata_localJsonData_returns20MetadataItems() {
        stubJsonLoader.stubData = dataFromLocalFlickrJsonFile
        var receivedImageMetadataArray: [RawImageMetadata] = []
        interactor.provideRawImageMetadata { (imageMetadataArray) in
            receivedImageMetadataArray = imageMetadataArray
        }
        XCTAssertEqual(receivedImageMetadataArray.count, 20)
    }
    
    func test_provideRawImageMetadata_localJsonData_firstImageMetadataHasCorrectValues() {
        stubJsonLoader.stubData = dataFromLocalFlickrJsonFile
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
