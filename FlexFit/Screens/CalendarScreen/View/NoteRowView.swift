import SwiftUI
import UserNotifications

struct NoteRowView: View {
    
    @EnvironmentObject private var viewModel: CalendarViewModel
    let note: Note
    
    var body: some View {
        VStack(spacing: 5) {
            
            Button {
                toggleNotification()
            } label: {
                Image(systemName: note.enableNotification
                      ? "bell.fill"
                      : "bell")
                .font(.title3)
                .foregroundColor(note.enableNotification
                                 ? Color.theme.text.main
                                 : Color.theme.text.main)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(timeFormatter(from: note.date ?? Date()))
                .font(.title2.weight(.bold))
                .foregroundColor(Color.theme.text.main)
            
            Text(dateFormatter(from: note.date ?? Date()))
                .font(.title3.weight(.semibold))
                .foregroundColor(Color.theme.text.main)
            
            Text(note.title)
                .font(.callout)
                .foregroundColor(Color.theme.text.main)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 11)
        .frame(maxWidth: .infinity)
        
        // Тут нужно назначать цвет из объекта note
        .background(Color(red: note.r, green: note.g, blue: note.b))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    
    private func timeFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func dateFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    
    // Управление уведомлениями
    private func toggleNotification() {
        if note.enableNotification {
            removePendingNotifications(for: note.id ?? UUID())
        } else {
            scheduleNotification(for: note.title, at: note.date ?? Date())
        }
        viewModel.updateNoteNotificationStatus(for: note, isEnabled: !note.enableNotification)
    }
    
    private func scheduleNotification(for title: String, at date: Date) {
        guard let noteId = note.id else {
            print("Note ID is nil. Cannot schedule notification.")
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Your scheduled note is due now!"
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: noteId.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func removePendingNotifications(for identifier: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier.uuidString])
    }
}

#Preview {
    
    let context = PersistenceController.preview.container.viewContext
    let sampleNote = Note(context: context)
    sampleNote.title = "Drink some water"
    sampleNote.date = Date()
    sampleNote.enableNotification = false
    
    
    return NoteRowView(note: sampleNote)
        .environmentObject(CalendarViewModel())
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background.main)
}
