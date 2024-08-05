import SwiftUI

struct NewButtonView: View {
    
    let buttonLabel: String
    @Binding var isPresented: Bool
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Text(buttonLabel)
                .font(.headline)
                .padding(.vertical, 15)
                .padding(.horizontal, 100)
                .foregroundColor(Color.theme.text.second)
                .background(Color.theme.other.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    NewButtonView(buttonLabel: "New note", isPresented: .constant(false))
}
