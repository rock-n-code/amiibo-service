struct Result<Model: Decodable> {
    let items: [Model]
}

// MARK: - Decodable

extension Result: Decodable {
    
    // MARK: Enumerations
    
    enum CodingKeys: String, CodingKey {
        case amiibo
    }
    
    // MARK: Initialisers
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.items = try container.decode([Model].self, forKey: .amiibo)
        } catch {
            self.items = [try container.decode(Model.self, forKey: .amiibo)]
        }
    }
    
}
