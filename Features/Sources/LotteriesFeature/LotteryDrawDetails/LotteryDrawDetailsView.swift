import SwiftUI
import DesignLibrary

public struct LotteryDrawDetailsView: View {
    
    @ObservedObject private var viewModel: LotteryDrawDetailsViewModel
    
    public init(viewModel: LotteryDrawDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            content
        }
        .padding(.horizontal)
        .navigationTitle("Lottery Draw Details")
    }
}

private extension LotteryDrawDetailsView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: .spacing.large) {
            lotteryBalls
            message
            generateTicketAction
            tickets
        }
    }
    
    var message: some View {
        Text("Good luck with your lottery ticket 🤞")
    }
    
    var lotteryBalls: some View {
        VStack(alignment: .leading, spacing: .spacing.large) {
            title(message: "Results")
            lotteryBallsView
        }
    }
    
    var lotteryBallsView: some View {
        LotteryBallsView(viewModels: viewModel.ballViewModels)
    }
    
    func title(message: String) -> some View {
        Text(message)
            .font(.title2)
            .bold()
    }
    
    var generateTicketAction: some View {
        Button("Generate ticket") {
            viewModel.onGenerateTicket()
        }
        .accessibilityIdentifier(AccessibilityIdentifiers.DrawDetailsScreen.generateTickets)
    }
    
    @ViewBuilder
    var tickets: some View {
        if !$viewModel.tickets.isEmpty {
            VStack(alignment: .leading, spacing: .spacing.large) {
                title(message: "Your tickets")
                
                ForEach(Array(viewModel.tickets.enumerated()), id: \.element.id) { index, ticket in
                    TicketView(viewModel: ticket)
                        .accessibilityIdentifier(AccessibilityIdentifiers.DrawDetailsScreen.ticket(at: index))
                }
            }
        }
    }
}
