import SwiftUI

public struct TitleDetailsView: View {

    private let title: String
    private let details: String
    
    public init(title: String, details: String) {
        self.title = title
        self.details = details
    }
    
    public var body: some View {
        HStack(spacing: .spacing.large) {
            Text(title)
                .font(.body).bold()
            Spacer()
            Text(details)
                .font(.body)
        }
        .contentShape(Rectangle())
    }
}
