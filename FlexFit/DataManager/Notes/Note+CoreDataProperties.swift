import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var date: Date?
    @NSManaged public var enableNotification: Bool

}

extension Note : Identifiable {

}
