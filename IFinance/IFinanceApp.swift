import SwiftUI

@main
struct MyApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainPageView()
            
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
