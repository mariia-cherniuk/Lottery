import SwiftUI

@main
struct LotteryApp: App {
    
    let appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            appCoordinator.makeRootView()
                .onOpenURL { _ in
                    //TODO: Deep link if needed with AppCoordinator
                }
        }
    }
}
