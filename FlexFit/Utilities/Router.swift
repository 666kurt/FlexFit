import Foundation

enum Screens: Hashable {
    case calendar
    case training
    case settings
}

class Router: ObservableObject {
    
    static let shared = Router.init()
    private init() {}
    
    @Published var selectedScreen: Screens = .calendar
}
