import XCTest
@testable import FlickrGallery

class URLFetchedAsyncImageTests: XCTestCase {

    var stubUrlSession: StubURLSession!
    var stubTask: StubURLSessionDataTask!
    var spyDispatcher: SpySyncDispatcher!
    var fakeUrl = URL(string: "foo://bar")!
    
    override func setUp() {
        super.setUp()
        stubTask = StubURLSessionDataTask()
        stubUrlSession = StubURLSession(dataTask: stubTask)
        spyDispatcher = SpySyncDispatcher()
    }
    
    override func tearDown() {
        stubTask = nil
        stubUrlSession = nil
        super.tearDown()
    }
    
    func test_fetchImage_sessionMakesCallToUrl() {
        let asyncImage = URLFetchedAsyncImage(url: fakeUrl, session: stubUrlSession, dispatcher: spyDispatcher)
        asyncImage.fetchImage { _ in }
        XCTAssertEqual(stubUrlSession.spyURL, fakeUrl)
    }
    
    func test_fetchImage_resumesDataTask() {
        let asyncImage = URLFetchedAsyncImage(url: fakeUrl, session: stubUrlSession, dispatcher: spyDispatcher)
        asyncImage.fetchImage { _ in }
        XCTAssertEqual(stubTask.spyNumResumeCalled, 1)
    }
}
