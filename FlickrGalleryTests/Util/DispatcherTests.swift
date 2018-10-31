import XCTest
@testable import FlickrGallery

class DispatcherTests: XCTestCase {

    func test_dispatchOnMain_executedOnMain() {
        let xpectation = expectation(description: "")
        Dispatcher().dispatchAsyncOnMain {
            XCTAssertTrue(Thread.isMainThread)
            xpectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_dispatchOnMain_executedAsynchronously() {
        var blockCalled = false
        Dispatcher().dispatchAsyncOnMain {
            blockCalled = true
        }
        XCTAssertFalse(blockCalled)
    }
}
