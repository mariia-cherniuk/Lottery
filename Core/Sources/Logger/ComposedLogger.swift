import Foundation

final class ComposedLogger: LoggerProtocol {
    
    private let loggers: [LoggerProtocol]
    
    init(loggers: [LoggerProtocol]) {
        self.loggers = loggers
    }
    
    func info(_ message: String) {
        for log in loggers {
            log.info(message)
        }
    }
}
