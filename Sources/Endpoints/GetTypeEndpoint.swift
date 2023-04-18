import Communications
import Foundation

struct GetTypeEndpoint: Endpoint {
    
    // MARK: Properties
    
    let scheme: String = .Scheme.https
    let host: String = .Host.amiiboApi
    let port: Int?
    let path: String = .Path.type
    let method: HTTPRequestMethod = .get
    let headers: [String : String] = [:]
    let body: Data?
    
}
