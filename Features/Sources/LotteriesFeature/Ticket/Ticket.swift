import DesignLibrary
import SwiftUI

struct Ticket {
    
    var message: String {
        hasWon ?
        "🎉 Congratulations! You have a winning ticket!" :
        "☹️ Your ticket didn't win. Better luck next time!"
    }
    
    let id = UUID()
    private let hasWon: Bool
    let ballViewModels: [BallViewModel]
    
    init(hasWon: Bool, ballViewModels: [BallViewModel]) {
        self.ballViewModels = ballViewModels
        self.hasWon = hasWon
    }
}
