import SwiftUI
import CoreData

struct MainView: View {
    
    @StateObject var router = Router.shared
    
    var body: some View {
        TabView(selection: $router.selectedScreen) {
            CalendarScreen()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }.tag(Screens.calendar)
            TrainingScreen()
                .tabItem {
                    Label("Training", systemImage: "figure.disc.sports")
                }.tag(Screens.training)
            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(Screens.settings)
        }
        .onAppear(perform: setupTabBarAppearance)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.theme.background.main)
        appearance.shadowColor = UIColor(Color.white.opacity(0.15))
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.text.notActive)
        UITabBar.appearance().tintColor = UIColor(Color.theme.other.primary)
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}


#Preview {
    MainView()
}
