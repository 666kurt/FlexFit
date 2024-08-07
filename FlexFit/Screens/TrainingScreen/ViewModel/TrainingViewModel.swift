import CoreData
import SwiftUI

class TrainingViewModel: ObservableObject {
    
    @Published var trainings: [Training] = []
    
    // Training props
    @Published var trainingLabel: String = ""
    @Published var trainingRepetitions: String = ""
    @Published var trainingApproaches: String = ""
    @Published var trainingWeight: String = ""
    @Published var trainingDescription: String = ""
    @Published var trainingDate: Date = Date()
    @Published var trainingTime: Double = 0.0
    @Published var restTime: Double = 0.0
    
    // Training statistic props
    @Published var trainingDays: String = "0"
    @Published var trainingHours: String = "0"
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchTrainings()
    }
    
    func fetchTrainingPlan() {
        let request: NSFetchRequest<TrainingPlan> = TrainingPlan.fetchRequest()
        do {
            let plans = try viewContext.fetch(request)
            if let plan = plans.first {
                trainingDays = plan.trainingDays
                trainingHours = plan.trainingHours
            }
        } catch {
            print("Error fetching training plan: \(error)")
        }
    }
    
    func saveTrainingPlan() {
        let request: NSFetchRequest<TrainingPlan> = TrainingPlan.fetchRequest()
        do {
            let plans = try viewContext.fetch(request)
            let plan = plans.first ?? TrainingPlan(context: viewContext)
            
            plan.trainingDays = trainingDays
            plan.trainingHours = trainingHours
            
            try viewContext.save()
        } catch {
            print("Error saving training plan: \(error)")
        }
    }
    
    func fetchTrainings() {
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        do {
            trainings = try viewContext.fetch(request)
        } catch {
            print("Error fetching trainings: \(error)")
        }
    }
    
    func addTraining() {
        let newTraining = Training(context: viewContext)
        newTraining.id = UUID()
        newTraining.title = trainingLabel
        newTraining.date = trainingDate
        newTraining.repetitions = trainingRepetitions
        newTraining.approaches = trainingApproaches
        newTraining.weight = trainingWeight
        newTraining.desc = trainingDescription
        newTraining.trainingTime = trainingTime
        newTraining.restTime = restTime
        
        saveContext()
        fetchTrainings()
        resetFields()
    }
    
    func deleteTraining(training: Training) {
        viewContext.delete(training)
        saveContext()
        fetchTrainings()
    }
    
    func updateTraining(training: Training, title: String, date: Date, repetitions: String, approaches: String, weight: String, description: String, trainingTime: Double, restTime: Double) {
        training.title = title
        training.date = date
        training.repetitions = repetitions
        training.approaches = approaches
        training.weight = weight
        training.desc = description
        training.trainingTime = trainingTime
        training.restTime = restTime
        
        saveContext()
        fetchTrainings()
    }
    
    func resetFields() {
        trainingLabel = ""
        trainingRepetitions = ""
        trainingApproaches = ""
        trainingWeight = ""
        trainingDescription = ""
        trainingDate = Date()
        trainingTime = 0.0
        restTime = 0.0
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

