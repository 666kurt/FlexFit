import SwiftUI

struct NewTrainingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: TrainingViewModel
    
    private let assetNames = ["training1", "training2", "training3", "training4", "training5", "training6", "training7", "training8", "training9", "training10", "training11", "training12", "training13", "training14", "training15", "training16"]
    
    private var rows: [GridItem] = [
        GridItem(.fixed(100), spacing: 1),
        GridItem(.fixed(100), spacing: 1)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 15) {
                    TextFieldView(placeholder: "Name training", queryText: $viewModel.trainingLabel)
                    
                    dateAndTimeView
                    
                    TextFieldView(placeholder: "Repetitions", queryText: $viewModel.trainingRepetitions)
                        .keyboardType(.decimalPad)
                    
                    TextFieldView(placeholder: "Approaches", queryText: $viewModel.trainingApproaches)
                        .keyboardType(.decimalPad)
                    
                    TextFieldView(placeholder: "Weight", queryText: $viewModel.trainingWeight)
                        .keyboardType(.decimalPad)
                    
                    TextFieldView(placeholder: "Enter description", queryText: $viewModel.trainingDescription)
                    
                    TrainingSliderView(title: "Training time", value: $viewModel.trainingTime, end: "60")
                    
                    TrainingSliderView(title: "Rest time", value: $viewModel.restTime, end: "60")
                    
                    
                    VStack(alignment: .leading) {
                        Text("Select a training image:")
                            .foregroundColor(Color.theme.text.main)
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, spacing: 10) {
                                ForEach(assetNames, id: \.self) { assetName in
                                    Image(assetName)
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .scaledToFit()
                                        .aspectRatio(1.5, contentMode: .fill)
                                        .frame(width: 150, height: 100)
                                        .opacity(viewModel.trainingImage == UIImage(named: assetName) ? 1 : 0.5)
                                        .onTapGesture {
                                            viewModel.trainingImage = UIImage(named: assetName)
                                        }
                                }
                            }
                        }
                    }

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
        !viewModel.trainingDescription.isEmpty &&
        !(viewModel.trainingImage == nil)
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

