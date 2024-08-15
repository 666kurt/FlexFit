import SwiftUI

struct TrainingDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    
    @State private var showEditingSheet: Bool = false
    @State private var showAlert: Bool = false
    let training: Training

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    
                    if let imageData = training.image, let image = UIImage.from(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    detailDateView
                    detailInfoView
                    detailDescriptionView
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
                            }.foregroundColor(Color.theme.other.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text(training.title)
                            .foregroundColor(.white)
                            .font(.headline)
                            .lineLimit(1)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            Button {
                                showEditingSheet.toggle()
                            } label: {
                                Image(systemName: "pencil")
                                    .foregroundColor(Color.theme.other.primary)
                            }
                            
                            Button {
                                showAlert.toggle()
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(Color.theme.other.primary)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showEditingSheet) {
                    TrainingDetailEditingView(training: training)
                }
                
                if showAlert {
                    AlertView(showAlert: $showAlert,
                              title: "Delete",
                              description: "Are you sure you want to delete?",
                              onDelete: {
                        trainingViewModel.deleteTraining(training: training)
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
    }
    
    private func dateFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

extension TrainingDetailView {
    
    private var detailInfoView: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                TrainingDetailCardView(image: "repeat",
                                       value: "\(training.repetitions)",
                                       title: "Repetitions")
                
                TrainingDetailCardView(image: "figure.run.square.stack",
                                       value: "\(training.approaches)",
                                       title: "Approaches")
                
                TrainingDetailCardView(image: "dumbbell",
                                       value: "\(training.weight)",
                                       title: "Weight")
            }
            HStack(spacing: 10) {
                TrainingDetailCardView(image: "clock",
                                       value: "\(Int(training.trainingTime.rounded())):00",
                                       title: "Training time")
                
                TrainingDetailCardView(image: "clock",
                                       value: "\(Int(training.restTime.rounded())):00",
                                       title: "Rest time")
            }
        }
    }
    
    private var detailDateView: some View {
        Text(dateFormatter(from: training.date ?? Date()))
            .font(.headline)
            .foregroundColor(Color.theme.text.main)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var detailDescriptionView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Description")
                .font(.headline).fontWeight(.semibold)
                .foregroundColor(Color.theme.text.main)
            
            Text(training.desc)
                .font(.footnote)
                .foregroundColor(Color.theme.text.notActive)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    sampleTraining.image = UIImage(named: "training1")?.pngData()
    
    return TrainingDetailView(training: sampleTraining)
        .environmentObject(TrainingViewModel())
}
