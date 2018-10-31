import XCTest
@testable import FlickrGallery

class FlickrJsonLoaderTests: XCTestCase {
    
    private var spySyncDispatcher: SpySyncDispatcher!
    private var stubDataTask: StubURLSessionDataTask!
    private var stubUrlSession: StubURLSession!
    private var jsonLoader: FlickrJsonLoader!
    
    override func setUp() {
        super.setUp()
        spySyncDispatcher = SpySyncDispatcher()
        stubDataTask = StubURLSessionDataTask()
        stubUrlSession = StubURLSession(dataTask: stubDataTask)
        jsonLoader = FlickrJsonLoader(urlSession: stubUrlSession, dispatcher: spySyncDispatcher)
    }
    
    override func tearDown() {
        spySyncDispatcher = nil
        stubDataTask = nil
        stubUrlSession = nil
        jsonLoader = nil
        super.tearDown()
    }
    
    func test_loadImageFeedJson_callsFlickrAPIWithCorrectURL() {
        jsonLoader.loadImageFeedJson { _ in }
        XCTAssertEqual(stubUrlSession.spyURL?.absoluteString, "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")
    }
    
    func test_loadImageFeedJson_startsDataTask() {
        jsonLoader.loadImageFeedJson { _ in }
        XCTAssertEqual(stubDataTask.spyNumResumeCalled, 1)
    }
    
    func test_loadImageFeedJson_dataReceived_callsCompletion() {
        var responseData: Data?
        let stubData = Data()
        stubUrlSession.stubData = stubData
        jsonLoader.loadImageFeedJson { data in
            responseData = data
        }
        XCTAssertEqual(responseData, stubData)
    }
    
    func test_loadImageFeedJson_dataReceived_callsCompletionOnMain() {
        stubUrlSession.stubData = Data()
        jsonLoader.loadImageFeedJson { data in
        }
        XCTAssertEqual(spySyncDispatcher.spyNumDispatchAsyncOnMainCalled, 1)
    }
    
    func test_loadImageFeedJson_noData_callsCompletionWithNoData() {
        var responseData: Data?
        var completionCalled = false
        stubUrlSession.stubData = nil
        jsonLoader.loadImageFeedJson { data in
            responseData = data
            completionCalled = true
        }
        XCTAssertNil(responseData)
        XCTAssertTrue(completionCalled)
    }
    
    func test_loadImageFeedJson_noData_callsCompletionOnMain() {
        stubUrlSession.stubData = nil
        jsonLoader.loadImageFeedJson { data in
        }
        XCTAssertEqual(spySyncDispatcher.spyNumDispatchAsyncOnMainCalled, 1)
    }
}
