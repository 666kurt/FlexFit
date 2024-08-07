import SwiftUI

struct NewNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: NoteViewModel
    @State private var noteLabel: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                dateAndTimeView
                TextFieldView(placeholder: "Enter note", queryText: $noteLabel)
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
    
    private func saveNote() {
        viewModel.addNote(title: noteLabel, date: viewModel.selectedDate)
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
        .environmentObject(NoteViewModel())
}
