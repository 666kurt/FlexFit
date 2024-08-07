import SwiftUI

struct EditPlanView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var trainingDays: String
    @Binding var trainingHours: String

    var onSave: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                TextFieldView(placeholder: "Quantity training days",
                              queryText: $trainingDays)
                .keyboardType(.decimalPad)
                
                TextFieldView(placeholder: "Number of training hours",
                              queryText: $trainingHours)
                .keyboardType(.decimalPad)

            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.theme.background.main.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture {
                UIApplication.shared.endEditing(true)
            }
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    Text("New note")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onSave()
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
        return !trainingDays.isEmpty && !trainingHours.isEmpty
    }
    
    private var saveButtonColor: Color {
        return saveButtonIsValid ? Color.theme.other.primary : Color.theme.text.notActive
    }
}

#Preview {
    EditPlanView(trainingDays: .constant("0"), trainingHours: .constant("0"), onSave: {})
}
