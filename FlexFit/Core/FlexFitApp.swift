import SwiftUI
import AppMetricaCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, 
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if let configuration = AppMetricaConfiguration(apiKey: "13d6ea88-d134-4c3f-abfe-f8f65362f039") {
            configuration.locationTracking = false
            AppMetrica.activate(with: configuration)
        }
        
        return true
    }
}

@main
struct FlexFitApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false

    var body: some Scene {
        WindowGroup {
            SplashScreen(showOnboarding: $showOnboarding, persistenceController: persistenceController)
                           .environment(\.managedObjectContext, persistenceController.container.viewContext)
                           
        }
    }
}
