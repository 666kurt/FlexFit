import SwiftUI

struct TrainingScreen: View {
    
    @State var showNewTraining: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            NavigationTitleView(title: "Training")
            
            trainingPlanView
            
            EmptyListView(emodji: "🏋🏻",
                          title: "Add your first training",
                          isPresented: $showNewTraining)
            
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.theme.background.main
                .ignoresSafeArea()
        )
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
                    //
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
                    Text("0")
                        .font(.title).bold()
                        .foregroundColor(Color.theme.other.primary)
                    Text("Quantity training days")
                        .font(.caption2)
                        .foregroundColor(Color.theme.text.notActive)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("0")
                        .font(.title).bold()
                        .foregroundColor(Color.theme.other.primary)
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
    
}

#Preview {
    TrainingScreen()
}
