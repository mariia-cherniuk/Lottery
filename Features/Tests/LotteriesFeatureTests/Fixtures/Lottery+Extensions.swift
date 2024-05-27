import LotteriesDomain
import Foundation

extension Lottery {
    
    //TODO: Hardcoding values to speed up a process. All properties should be injected as function parameters to enable dynamic testing and verification of each value's correctness. It is typically required when working with a transformer object
    
    static func fixture(id: String = "id", drawDate: Date = Date()) -> Self { //TODO: fix date, because it won't work in test on a next day
        Lottery(id: id, drawDate: drawDate, number1: 2, number2: 16, number3: 23, number4: 44, number5: 47, number6: 52, bonusBall: 14, topPrize: 4000000000)
    }
}

//"2023-05-15"
