public struct ErrorViewModel {
    
    public let title: String
    public let message: String
    public let actionTitle: String
    let action: () async -> Void
    
    public init(title: String, message: String, actionTitle: String, action: @escaping () async -> Void) {
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }
}
