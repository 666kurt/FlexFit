import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        return result
    }()
    
    init() {
        container = NSPersistentContainer(name: "FlexFit")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
}
