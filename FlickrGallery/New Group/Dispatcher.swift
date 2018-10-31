import Foundation

protocol Dispatching {
    func dispatchAsyncOnMain(block: @escaping () -> Void)
}

final class Dispatcher {

    func dispatchAsyncOnMain(block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}
