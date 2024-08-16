import SwiftUI

struct TrainingDetailEditingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    
    private let assetNames = ["training1", "training2", "training3", "training4", "training5", "training6", "training7", "training8", "training9", "training10", "training11", "training12", "training13", "training14", "training15", "training16"]
    
    var rows: [GridItem] = [
        GridItem(.fixed(100), spacing: 15),
        GridItem(.fixed(100))
    ]
    
    @StateObject var training: Training
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
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

                    
                    VStack(alignment: .leading) {
                        Text("Select a training image:")
                            .foregroundColor(Color.theme.text.main)
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, spacing: 15) {
                                ForEach(assetNames, id: \.self) { assetName in
                                    Image(assetName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .opacity(training.image == UIImage(named: assetName)?.pngData() ? 1 : 0.5)
                                        .onTapGesture {
                                            training.image = UIImage(named: assetName)?.pngData()
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
                                                         restTime: training.restTime,
                                                         image: UIImage(data: training.image ?? Data()))
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
