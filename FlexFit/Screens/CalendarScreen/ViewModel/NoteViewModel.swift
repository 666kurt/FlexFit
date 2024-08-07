import SwiftUI
import CoreData

class NoteViewModel: ObservableObject {
    @Published var notesForSelectedDate: [Note] = []
    @Published var selectedDate: Date = Date()
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
        fetchNotes(for: selectedDate)
    }
    
    func fetchNotes(for date: Date) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        
        do {
            notesForSelectedDate = try viewContext.fetch(request)
        } catch {
            print("Error fetching notes: \(error)")
            notesForSelectedDate = []
        }
    }
    
    func addNote(title: String, date: Date, enableNotification: Bool = false) {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.date = date
        newNote.enableNotification = enableNotification
        
        do {
            try viewContext.save()
            fetchNotes(for: selectedDate)
        } catch {
            print("Error saving new note: \(error)")
        }
    }
    
    func deleteNotes(at offsets: IndexSet) {
        offsets.map { notesForSelectedDate[$0] }.forEach(viewContext.delete)
        do {
            try viewContext.save()
        } catch {
            print("Error saving after deletion: \(error)")
        }
        fetchNotes(for: selectedDate)
    }
    
    func updateNoteNotificationStatus(for note: Note, isEnabled: Bool) {
        note.enableNotification = isEnabled
        do {
            try viewContext.save()
        } catch {
            print("Error saving note notification status: \(error)")
        }
        fetchNotes(for: selectedDate)
    }
}

