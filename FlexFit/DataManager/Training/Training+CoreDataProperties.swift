import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var date: Date?
    @NSManaged public var repetitions: String
    @NSManaged public var approaches: String
    @NSManaged public var weight: String
    @NSManaged public var desc: String
    @NSManaged public var trainingTime: Double
    @NSManaged public var restTime: Double
    @NSManaged public var image: Data?

}

extension Training : Identifiable {

}
