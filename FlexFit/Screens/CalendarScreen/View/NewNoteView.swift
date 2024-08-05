import SwiftUI

struct NewNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var noteLabel: String = ""
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                dateAndTimeView
                
                TextFieldView(placeholder: "Enter note",
                              queryText: $noteLabel)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.theme.background.main.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("New note")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .foregroundColor(saveButtonColor)
                    }
                    .disabled(!saveButtonIsValid)
                }
            }
        }
    }
    
    private var saveButtonIsValid: Bool {
        return !noteLabel.isEmpty
    }
    
    private var saveButtonColor: Color {
        return saveButtonIsValid ? Color.theme.other.primary : Color.theme.text.notActive
    }
}

extension NewNoteView {
    private var dateAndTimeView: some View {
        HStack {
            HStack {
                Text("Date")
                DatePicker("",
                           selection: $selectedDate,
                           displayedComponents: .date)
            }
            Spacer()
            HStack {
                Text("Time")
                DatePicker("",
                           selection: $selectedDate,
                           displayedComponents: .hourAndMinute)
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
}
