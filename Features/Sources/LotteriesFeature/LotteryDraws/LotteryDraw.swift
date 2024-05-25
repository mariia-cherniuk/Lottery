import LotteriesDomain

public struct LotteryDraw: Hashable {

    var id: String {
        draw.id
    }
    
    var date: String {
        draw.drawDate
    }
    
    private let draw: Lottery
    
    init(draw: Lottery) {
        self.draw = draw
    }
    
    public static func == (lhs: LotteryDraw, rhs: LotteryDraw) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
    }
}
