import XCTest
@testable import FlickrGallery

class FlickrJsonLoaderTests: XCTestCase {
    
    private var spySyncDispatcher: SpySyncDispatcher!
    private var spyDataTask: SpyURLSessionDataTask!
    private var spyAndStubUrlSession: SpyAndStubURLSession!
    private var jsonLoader: FlickrJsonLoader!
    
    override func setUp() {
        super.setUp()
        spySyncDispatcher = SpySyncDispatcher()
        spyDataTask = SpyURLSessionDataTask()
        spyAndStubUrlSession = SpyAndStubURLSession(dataTask: spyDataTask)
        jsonLoader = FlickrJsonLoader(urlSession: spyAndStubUrlSession, dispatcher: spySyncDispatcher)
    }
    
    override func tearDown() {
        spySyncDispatcher = nil
        spyDataTask = nil
        spyAndStubUrlSession = nil
        jsonLoader = nil
        super.tearDown()
    }
    
    func test_loadImageFeedJson_callsFlickrAPIWithCorrectURL() {
        jsonLoader.loadImageFeedJson { _ in }
        XCTAssertEqual(spyAndStubUrlSession.spyURL?.absoluteString, "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1")
    }
    
    func test_loadImageFeedJson_startsDataTask() {
        jsonLoader.loadImageFeedJson { _ in }
        XCTAssertEqual(spyDataTask.spyNumResumeCalled, 1)
    }
    
    func test_loadImageFeedJson_dataReceived_callsCompletion() {
        var responseData: Data?
        let stubData = Data()
        spyAndStubUrlSession.stubData = stubData
        jsonLoader.loadImageFeedJson { data in
            responseData = data
        }
        XCTAssertEqual(responseData, stubData)
    }
    
    func test_loadImageFeedJson_dataReceived_callsCompletionOnMain() {
        spyAndStubUrlSession.stubData = Data()
        jsonLoader.loadImageFeedJson { data in
        }
        XCTAssertEqual(spySyncDispatcher.spyNumDispatchAsyncOnMainCalled, 1)
    }
    
    func test_loadImageFeedJson_noData_callsCompletionWithNoData() {
        var responseData: Data?
        var completionCalled = false
        spyAndStubUrlSession.stubData = nil
        jsonLoader.loadImageFeedJson { data in
            responseData = data
            completionCalled = true
        }
        XCTAssertNil(responseData)
        XCTAssertTrue(completionCalled)
    }
    
    func test_loadImageFeedJson_noData_callsCompletionOnMain() {
        spyAndStubUrlSession.stubData = nil
        jsonLoader.loadImageFeedJson { data in
        }
        XCTAssertEqual(spySyncDispatcher.spyNumDispatchAsyncOnMainCalled, 1)
    }
}
