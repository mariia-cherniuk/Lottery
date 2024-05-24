import SwiftUI
import JSONService
import LotteriesDomain

final class AppCoordinator {
    
    private let useCaseFactory = UseCaseFactory(fileManager: FileDataManager())
}
