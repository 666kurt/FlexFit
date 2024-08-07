import SwiftUI

struct NewTrainingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TrainingViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                
                TextFieldView(placeholder: "Name training", queryText: $viewModel.trainingLabel)
                
                dateAndTimeView
                
                TextFieldView(placeholder: "Repetitions", queryText: $viewModel.trainingRepetitions)
                
                TextFieldView(placeholder: "Approaches", queryText: $viewModel.trainingApproaches)
                
                TextFieldView(placeholder: "Weight", queryText: $viewModel.trainingWeight)
                
                TextFieldView(placeholder: "Enter description", queryText: $viewModel.trainingDescription)
                
                TrainingSliderView(title: "Training time", value: $viewModel.trainingTime, end: "60")
                
                TrainingSliderView(title: "Rest time", value: $viewModel.restTime, end: "60")
                
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
                    Text("New Training")
                        .foregroundColor(.white)
                        .font(.headline)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.addTraining()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .foregroundColor(saveButtonColor)
                    }.disabled(!saveButtonIsValid)
                }
            }
        }
    }

    private var saveButtonIsValid: Bool {
        return !viewModel.trainingLabel.isEmpty &&
        !viewModel.trainingRepetitions.isEmpty &&
        !viewModel.trainingApproaches.isEmpty &&
        !viewModel.trainingWeight.isEmpty &&
        !viewModel.trainingDescription.isEmpty
    }

    private var saveButtonColor: Color {
        return saveButtonIsValid ? Color.theme.other.primary : Color.theme.text.notActive
    }
}

extension NewTrainingView {
    private var dateAndTimeView: some View {
        HStack {
            HStack {
                Text("Date")
                DatePicker("",
                           selection: $viewModel.trainingDate,
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
    NewTrainingView()
        .environmentObject(TrainingViewModel())
}

