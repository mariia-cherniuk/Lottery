import LotteriesDomain

struct LotteryDraw {
    
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
}
