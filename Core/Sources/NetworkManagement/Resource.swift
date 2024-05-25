import Foundation

public struct Resource {
    
    public let path: String
    public let method: HTTPMethod
    public let query: [String : String]

    public init(path: String, method: HTTPMethod = .GET, query: [String: String] = [:]) {
        self.path = path
        self.method = method
        self.query = query
    }

    func request(relativeTo environment: Environment) -> URLRequest {
        var components = URLComponents()
        
        components.scheme = environment.schema
        components.host = environment.host
        components.path = path
        
        if !query.isEmpty {
            components.queryItems = query.map { key, value in URLQueryItem(name: key, value: value) }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        return request
    }
}
