import Foundation
import CoreData
import SwiftUI

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var date: Date?
    @NSManaged public var enableNotification: Bool
    @NSManaged public var a: Double
    @NSManaged public var r: Double
    @NSManaged public var g: Double
    @NSManaged public var b: Double

}

extension Note : Identifiable {

}
