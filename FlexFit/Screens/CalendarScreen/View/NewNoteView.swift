import SwiftUI

struct NewNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: CalendarViewModel
    
    @State private var noteLabel: String = ""
    
    // Новое поле для хранения цвета
    @State private var noteColor: Color = .red
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                dateAndTimeView
                TextFieldView(placeholder: "Enter note", queryText: $noteLabel)
                
                
                // Выбор цвета для заметки
                ZStack(alignment: .leading) {
                        Text("Choose color of note")
                            .font(.callout)
                            .foregroundColor(Color.theme.text.notActive)
                    ColorPicker("", selection: $noteColor)
                        .colorScheme(.dark)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12.5)
                .foregroundColor(Color.theme.text.main)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.theme.other.primary, lineWidth: 2)
                )
                .background(Color.theme.background.main)
            
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.theme.background.main.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("New note").foregroundColor(.white).font(.headline)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveNote) {
                        Text("Save").foregroundColor(saveButtonColor)
                    }
                    .disabled(noteLabel.isEmpty)
                }
            }
        }
    }
    
    private var saveButtonColor: Color {
        return noteLabel.isEmpty ? Color.theme.text.notActive : Color.theme.other.primary
    }
    
    // Тут нужно добавить сохранения цвета
    private func saveNote() {
        
        let red = Double(noteColor.components.r)
        let green = Double(noteColor.components.g)
        let blue = Double(noteColor.components.b)
        let alpha = Double(noteColor.components.a)
        
        
        viewModel.addNote(title: noteLabel, date: viewModel.selectedDate, a: alpha, r: red, g: green, b: blue)
        presentationMode.wrappedValue.dismiss()
    }
}

extension NewNoteView {
    private var dateAndTimeView: some View {
        HStack {
            HStack {
                Text("Date")
                DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .date)
            }
            Spacer()
            HStack {
                Text("Time")
                DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .hourAndMinute)
            }
        }
        .labelsHidden()
        .colorScheme(.dark)
        .font(.headline)
        .foregroundColor(Color.theme.text.main)
    }
}

#Preview {
    NewNoteView()
        .environmentObject(CalendarViewModel())
}
