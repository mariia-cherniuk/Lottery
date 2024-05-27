import OSLog

public protocol LoggerProtocol {
    func info(_ message: String)
}

public final class OSLogger: LoggerProtocol {
    
    private let logger: Logger
    
    public init(logger: Logger) {
        self.logger = logger
    }
    
    public func info(_ message: String) {
        logger.info("\(message)")
    }
}
