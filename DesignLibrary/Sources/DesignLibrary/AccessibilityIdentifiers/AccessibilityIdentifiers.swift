public enum AccessibilityIdentifiers {
    public enum DrawsSceen {
        public static let name = "DrawsScreen"
    
        public static func draw(at index: Int) -> String {
            return "Draw \(index)"
        }
    }
    
    public enum DrawDetailsSceen {
        public static let name = "DrawDetailsScreen"
        public static let generateTickets = "Generate Tickets"
    }
}
