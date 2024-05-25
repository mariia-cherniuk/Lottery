import LotteriesDomain

struct LotteryDraw {

    var id: String {
        lottery.id
    }
    
    var date: String {
        lottery.drawDate
    }
    
    let lottery: Lottery
    
    init(lottery: Lottery) {
        self.lottery = lottery
    }
}
