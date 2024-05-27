import Combine
import Foundation
import OSLog
import Logger

public enum NetworkError: Error {
    case networkError(Error)
    case invalidResponse
    case notConnectedToInternet
}

public protocol DataLoading {
    func fetch(resource: Resource) async throws -> Data
}

public final class DataLoader: DataLoading {
    
    private let session: URLSessionProtocol
    private let environment: Environment
    
    public init(session: URLSessionProtocol = URLSession.shared, environment: Environment) {
        self.session = session
        self.environment = environment
    }
    
    public func fetch(resource: Resource) async throws -> Data {
        let request = resource.request(relativeTo: environment)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            return data
        } catch let error as URLError where error.code == .notConnectedToInternet {
            Logger.sharedLogger.info("Error description:\n\(error)")
            throw NetworkError.notConnectedToInternet
        } catch let error as NetworkError {
            Logger.sharedLogger.info("Error description:\n\(error)")
            ///Fix Swift runtime bug
            ///throw NetworkError.invalidResponse does not exit the method but instead seems to be caught by a last catch block.
            ///The thrown error should be propagated up to the caller, where it can be caught and handled.
            throw error
        } catch {
            Logger.sharedLogger.info("Error description:\n\(error)")
            throw NetworkError.networkError(error)
        }
    }
}
