public enum AccessibilityIdentifiers {
    public enum DrawsScreen {
        public static let name = "DrawsScreen"
    
        public static func draw(at index: Int) -> String {
            return "Draw \(index)"
        }
    }
    
    public enum DrawDetailsScreen {
        public static let name = "DrawDetailsScreen"
        public static let generateTickets = "GenerateTickets"
        
        public static func ticket(at index: Int) -> String {
            return "Ticket \(index)"
        }
    }
}
