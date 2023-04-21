import Communications
import Foundation

extension MockURLRequest {
    
    // MARK: Initialisers
    
    init(url: URL) {
        self.init(method: .get, url: url)
    }

}
