import SwiftUI
import UserNotifications

struct NoteRowView: View {
    
    @EnvironmentObject private var viewModel: CalendarViewModel
    let note: Note
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(note.title)
                    .foregroundColor(Color.theme.text.main)
                    .lineLimit(1)
                
                Spacer()
                
                HStack(spacing: 15) {
                    Text(timeFormatter(from: note.date ?? Date()))
                        .foregroundColor(Color.theme.text.notActive)
                    
                    Rectangle()
                        .frame(width: 0.5, height: 25)
                        .foregroundColor(Color(hex: "#38383A"))
                    
                    Button {
                        toggleNotification()
                    } label: {
                        Image(systemName: note.enableNotification
                              ? "bell.fill"
                              : "bell")
                        .font(.title3)
                        .foregroundColor(note.enableNotification
                                         ? Color.theme.other.primary
                                         : Color.theme.text.main)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 15)
            
            Divider()
                .frame(height: 3)
                .background(Color.theme.other.primary)
            
        }
        .padding(.top, 5)
        .frame(maxWidth: .infinity)
        
    }
    
    private func timeFormatter(from date: Date) -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
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
    CalendarScreen()
        .environmentObject(CalendarViewModel())
}
