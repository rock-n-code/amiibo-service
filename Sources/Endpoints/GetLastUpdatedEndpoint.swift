import Communications
import Foundation

struct GetLastUpdatedEndpoint: Endpoint {
    
    // MARK: Properties
    
    let scheme: String = .Scheme.https
    let host: String = .Host.amiiboApi
    let port: Int? = nil
    let path: String = .Path.lastUpdated
    let parameters: Parameters = [:]
    let method: HTTPRequestMethod = .get
    let headers: [String : String] = [:]
    let body: Data? = nil
    
}
