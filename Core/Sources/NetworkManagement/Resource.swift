import Foundation

public struct Resource {
    
    public let path: String
    public let method: HTTPMethod
    
    public init(path: String, method: HTTPMethod = .GET) {
        self.path = path
        self.method = method
    }

    func request(relativeTo environment: Environment) -> URLRequest {
        var components = URLComponents()
        
        components.scheme = environment.schema
        components.host = environment.host
        components.path = path
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        return request
    }
}
