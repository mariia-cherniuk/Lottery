import LotteriesDomain

public protocol LotteriesCoordinating {
    func showDetails(_ lottery: Lottery)
    func showTabbedDetails(_ lottery: [Lottery])
}
