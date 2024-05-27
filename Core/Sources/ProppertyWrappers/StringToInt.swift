@propertyWrapper
public struct StringToInt: Codable, Hashable {
    
    public var wrappedValue: Int
    
    public init(wrappedValue: Int) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        
        if let intValue = Int(stringValue) {
            self.wrappedValue = intValue
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected an integer value but got a string: \(stringValue)")
        }
    }
}
