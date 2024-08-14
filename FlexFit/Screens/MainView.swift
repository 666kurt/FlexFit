import SwiftUI
import CoreData
import UserNotifications

struct MainView: View {
    
    @StateObject var router = Router.shared
    @StateObject var noteViewModel = CalendarViewModel()
    @StateObject var trainingViewModel = TrainingViewModel()
    
    var body: some View {
        TabView(selection: $router.selectedScreen) {
            CalendarScreen()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }.tag(Screens.calendar)
                .environmentObject(noteViewModel)
            TrainingScreen()
                .tabItem {
                    Label("Training", systemImage: "figure.disc.sports")
                }.tag(Screens.training)
                .environmentObject(trainingViewModel)
            SettingsScreen()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }.tag(Screens.settings)
        }
        .onAppear() {
            setupTabBarAppearance()
            requestNotificationPermissions()
        }
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
    
    func requestNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notifications permission: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    MainView()
        .environmentObject(CalendarViewModel())
        .environmentObject(TrainingViewModel())
}
