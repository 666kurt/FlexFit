import SwiftUI

struct TrainingDetailCardView: View {
    
    let image: String
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                Image(systemName: image)
                Text(value)
                    .bold()
                    .lineLimit(1)
            }
            .font(.title2)
            .foregroundColor(Color.theme.other.primary)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(Color.theme.text.notActive)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 13)
        .background(Color.theme.background.second)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    TrainingDetailCardView(image: "repeat",
                           value: "15",
                           title: "Repetitions")
}
