import SwiftUI

struct TrainingRowView: View {
    
    var trainingName: String
    var trainingDate: Date
    var action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(trainingName)
                    .font(.body).fontWeight(.semibold)
                    .foregroundColor(Color.theme.text.notActive)
                Text(dateFormatter(from: trainingDate))
                    .font(.subheadline)
                    .foregroundColor(Color.theme.text.main)
            }
            
            Spacer()
            
            Button {
                action()
            } label: {
                Text("More")
                    .font(.subheadline)
                    .foregroundColor(Color.theme.other.primary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(Color.theme.background.second)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private func dateFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    TrainingRowView(trainingName: "Cardio",
                    trainingDate: Date(), action: {})
        .padding()
}
