import OSLog

extension Logger {
    
    private static let ordinary = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Logger")
    
    #if DEBUG
        static let sharedLogger = OSLogger(logger: ordinary)
    #endif
    #if RELEASE
        static let sharedLogger = ComposedLogger(loggers: [
            RemoteLogger(),
            OSLogger(logger: core)
        ])
    #endif
}
