public struct Environment {
   
    let schema: String
    let host: String
    
    public init(schema: String, host: String) {
        self.schema = schema
        self.host = host
    }
}
