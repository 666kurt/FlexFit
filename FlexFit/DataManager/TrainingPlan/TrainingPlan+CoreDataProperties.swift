import Foundation
import CoreData


extension TrainingPlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainingPlan> {
        return NSFetchRequest<TrainingPlan>(entityName: "TrainingPlan")
    }

    @NSManaged public var trainingDays: String
    @NSManaged public var trainingHours: String

}

extension TrainingPlan : Identifiable {

}
