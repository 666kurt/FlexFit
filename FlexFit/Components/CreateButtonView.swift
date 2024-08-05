import SwiftUI

struct CreateButtonView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Create")
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 55)
            .foregroundColor(Color.theme.text.second)
            .background(Color.theme.other.primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    CreateButtonView(isPresented: .constant(false))
}
