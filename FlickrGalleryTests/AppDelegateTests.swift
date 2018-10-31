import XCTest
@testable import FlickrGallery

class AppDelegateTests: XCTestCase {

    private var delegate: AppDelegate? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return delegate
    }
    
    func test_didFinishLaunching_createsWindow() {
        let _ = delegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertNotNil(delegate?.window)
    }
    
    func test_didFinishLaunching_Succeeds() {
        let success = delegate?.application(UIApplication.shared, didFinishLaunchingWithOptions: nil) ?? false
        XCTAssertTrue(success)
    }
    
    func test_startApp_showsGalleryScreen() {
        let appCoordinator = StubAppCoordinator()
        delegate?.startApp(appCoordinator: appCoordinator)
        XCTAssertEqual(appCoordinator.spyNumShowGalleryScreenCalled, 1)
    }
}
