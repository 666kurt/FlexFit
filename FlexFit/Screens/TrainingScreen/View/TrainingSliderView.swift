import SwiftUI

struct TrainingSliderView: View {
    
    let title: String
    @Binding var value: Double
    let end: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .foregroundColor(Color.theme.text.main)
                .font(.headline)
            HStack {
                Text("\(Int(value.rounded()))")
                    .foregroundColor(.white)
                    .frame(width: 22)
                Slider(value: $value, in: 0...60)
                Text(end)
                    .foregroundColor(.white)
                    .frame(width: 22)
            }
        }

    }
}

#Preview {
    TrainingSliderView(title: "Rest time",
                       value: .constant(0),
                       end: "60")
}
