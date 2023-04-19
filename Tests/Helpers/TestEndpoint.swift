import Communications
import Foundation

struct TestEndpoint: Endpoint {
    
    // MARK: Properties
    
    let scheme: String = "http"
    let host: String = "www.something.com"
    let port: Int? = nil
    let path: String = "/path/to/endpoint"
    let parameters: Parameters = [:]
    let method: HTTPRequestMethod = .get
    let headers: [String : String] = [:]
    let body: Data? = nil

}
