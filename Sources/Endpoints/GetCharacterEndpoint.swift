import Communications
import Foundation

struct GetCharacterEndpoint: Endpoint {
    
    // MARK: Properties
    
    let scheme: String = .Scheme.https
    let host: String = .Host.amiiboApi
    let port: Int? = nil
    let path: String = .Path.character
    let parameters: Parameters
    let method: HTTPRequestMethod = .get
    let headers: [String : String] = [:]
    let body: Data? = nil
    
    // MARK: Initialisers
    
    init(parameters: Parameters) {
        self.parameters = parameters
    }
    
}
