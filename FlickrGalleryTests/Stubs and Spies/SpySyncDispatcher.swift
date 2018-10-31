import Foundation
@testable import FlickrGallery

final class SpySyncDispatcher: Dispatching {
    
    var spyNumDispatchAsyncOnMainCalled = 0
    
    func dispatchAsyncOnMain(block: @escaping () -> Void) {
        block()
        spyNumDispatchAsyncOnMainCalled += 1
    }
}
