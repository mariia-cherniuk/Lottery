import OSLog

protocol LoggerProtocol {
    func info(_ message: String)
}

final class OSLogger: LoggerProtocol {
    
    private let logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func info(_ message: String) {
        logger.info("\(message)")
    }
}
