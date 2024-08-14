import SwiftUI

struct TrainingScreen: View {
    @EnvironmentObject private var trainingViewModel: TrainingViewModel
    
    @State private var showNewTraining = false
    @State private var showEditPlan = false
    
    @State private var selectedTraining: Training?
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationTitleView(title: "Training")
            
            trainingPlanView
            
            if trainingViewModel.trainings.isEmpty {
                EmptyListView(
                    emodji: "🏋🏻",
                    title: "Add your first training",
                    isPresented: $showNewTraining
                )
            } else {
                listTrainingView
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.background.main.ignoresSafeArea())
        
        // Создание тренировки
        .fullScreenCover(isPresented: $showNewTraining) {
            NewTrainingView()
                .environmentObject(trainingViewModel)
        }
        
        // Детальный экран тренировки
        .fullScreenCover(item: $selectedTraining) { training in
            TrainingDetailView(training: training)
                .environmentObject(trainingViewModel)
        }
        
        // Редактирование плана тренировки
        .sheet(isPresented: $showEditPlan) {
            EditPlanView(
                trainingDays: $trainingViewModel.trainingDays,
                trainingHours: $trainingViewModel.trainingHours
            ) {
                trainingViewModel.saveTrainingPlan()
            }
        }
        .onAppear {
            trainingViewModel.fetchTrainingPlan()
            trainingViewModel.fetchTrainings()
        }
    }
}

extension TrainingScreen {
    private var trainingPlanView: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Training plan for month")
                    .font(.caption2)
                    .foregroundColor(Color.theme.text.notActive)
                
                Spacer()
                
                Button {
                    showEditPlan.toggle()
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit plan")
                    }
                    .font(.footnote)
                    .foregroundColor(Color.theme.other.primary)
                }
            }
            
            HStack {
                VStack(spacing: 4) {
                    Text(trainingViewModel.trainingDays)
                        .font(.title).bold()
                        .foregroundColor(Color.theme.other.primary)
                        .frame(maxWidth: 50, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: false)
                        .truncationMode(.tail)
                    Text("Quantity training days")
                        .font(.caption2)
                        .foregroundColor(Color.theme.text.notActive)
                    
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text(trainingViewModel.trainingHours)
                        .font(.title).bold()
                        .foregroundColor(Color.theme.other.primary)
                        .frame(maxWidth: 50, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: false)
                        .truncationMode(.tail)
                    Text("Number of training hours")
                        .font(.caption2)
                        .foregroundColor(Color.theme.text.notActive)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background.second)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    private var listTrainingView: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 15) {
                    ForEach(trainingViewModel.trainings) { training in
                        TrainingRowView(trainingName: training.title,
                                        trainingDate: training.date ?? Date(), action: {
                            selectedTraining = training
                        })
                    }
                }
            }
            
            NewButtonView(buttonLabel: "New training", isPresented: $showNewTraining)
        }
    }
}

#Preview {
    TrainingScreen()
        .environmentObject(TrainingViewModel())
}

