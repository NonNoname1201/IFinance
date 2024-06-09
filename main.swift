import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainPageView()
        }
    }
}

struct MyApp_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}