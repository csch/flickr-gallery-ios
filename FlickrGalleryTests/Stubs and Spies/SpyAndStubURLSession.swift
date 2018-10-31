import Foundation

final class SpyURLSessionDataTask: URLSessionDataTask {
    
    var spyNumResumeCalled = 0
    
    override func resume() {
        spyNumResumeCalled += 1
    }
}

final class SpyAndStubURLSession: URLSession {
    
    let dataTask: URLSessionDataTask
    var stubData: Data?
    var stubResponse: URLResponse?
    var stubError: Error?
    var spyURL: URL?
    
    init(dataTask: URLSessionDataTask) {
        self.dataTask = dataTask
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        spyURL = url
        completionHandler(stubData, stubResponse, stubError)
        return dataTask
    }
}
