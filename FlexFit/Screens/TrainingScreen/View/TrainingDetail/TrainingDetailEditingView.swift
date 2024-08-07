import SwiftUI

struct TrainingDetailEditingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    
    @StateObject var training: Training
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    
                    
                    TextFieldView(placeholder: "Name training", queryText: $training.title)
                    
                    dateAndTimeView
                    
                    TextFieldView(placeholder: "Repetitions", queryText: $training.repetitions)
                        .keyboardType(.decimalPad)
                    
                    TextFieldView(placeholder: "Approaches", queryText: $training.approaches)
                        .keyboardType(.decimalPad)
                    
                    TextFieldView(placeholder: "Weight", queryText: $training.weight)
                        .keyboardType(.decimalPad)
                    
                    TextFieldView(placeholder: "Enter description", queryText: $training.desc)
                    
                    TrainingSliderView(title: "Training time", value: $training.trainingTime, end: "60")
                    
                    TrainingSliderView(title: "Rest time", value: $training.restTime, end: "60")
                    
                    
                }
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
                    Text("Edit")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        trainingViewModel.updateTraining(training: training,
                                                         title: training.title,
                                                         date: training.date ?? Date(),
                                                         repetitions: training.repetitions,
                                                         approaches: training.approaches,
                                                         weight: training.weight,
                                                         description: training.desc,
                                                         trainingTime: training.trainingTime,
                                                         restTime: training.restTime)
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
        !training.title.isEmpty &&
        !training.repetitions.isEmpty &&
        !training.approaches.isEmpty &&
        !training.weight.isEmpty &&
        !training.desc.isEmpty
    }
    
    private var saveButtonColor: Color {
        return saveButtonIsValid ? Color.theme.other.primary : Color.theme.text.notActive
    }
}

extension TrainingDetailEditingView {
    private var dateAndTimeView: some View {
        HStack {
            HStack {
                Text("Date")
                DatePicker("",
                           selection: Binding(
                            get: { training.date ?? Date() },
                            set: { training.date = $0 }
                           ),
                           displayedComponents: .date)
            }
            Spacer()
        }
        .labelsHidden()
        .colorScheme(.dark)
        .font(.headline)
        .foregroundColor(Color.theme.text.main)
    }
}


#Preview {
    
    let context = PersistenceController.preview.container.viewContext
    let sampleTraining = Training(context: context)
    sampleTraining.title = "Sample Training"
    sampleTraining.date = Date()
    sampleTraining.repetitions = "10"
    sampleTraining.approaches = "3"
    sampleTraining.weight = "20"
    sampleTraining.desc = "Sample Description"
    sampleTraining.trainingTime = 45
    sampleTraining.restTime = 15
    
    return TrainingDetailEditingView(training: sampleTraining)
}
