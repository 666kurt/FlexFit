import SwiftUI

struct TrainingRowView: View {
    
    var trainingName: String
    var trainingDate: Date
    var trainingImage: Data?
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
        
            if let imageData = trainingImage, let image = UIImage.from(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaledToFit()
                    .aspectRatio(1.5, contentMode: .fill)
                    .frame(width: 100, height: 50)
            }
            
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
    TrainingScreen()
        .environmentObject(TrainingViewModel())
}
