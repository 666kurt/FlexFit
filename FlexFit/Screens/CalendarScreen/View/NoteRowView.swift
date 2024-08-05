import SwiftUI

struct NoteRowView: View {
    
    let noteLabel: String
    let noteTime: Date
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(noteLabel)
                    .foregroundColor(Color.theme.text.main)
                
                Spacer()
                
                HStack {
                    Text(timeFormatter(from: noteTime))
                        .foregroundColor(Color.theme.text.notActive)
                    
                    Rectangle()
                        .frame(width: 0.5, height: .infinity)
                        .foregroundColor(Color(hex: "#38383A"))
                    
                    Image(systemName: "bell")
                        .font(.title3)
                        .foregroundColor(Color.theme.text.main)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 15)
            
            Divider()
                .frame(height: 3)
                .background(Color.theme.other.primary)
            
        }
        .padding(.top, 15)
        .frame(maxWidth: .infinity)
    }
    
    private func timeFormatter(from date: Date) -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
//    NoteRowView(noteLabel: "Buy cocktail products", 
//                noteTime: Date())
//    .background(Color.theme.background.main)
    
    CalendarScreen()
}
