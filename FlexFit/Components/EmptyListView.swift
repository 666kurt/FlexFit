import SwiftUI

struct EmptyListView: View {
    
    let emodji: String
    let title: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 14) {
            Text(emodji)
                .font(.system(size: 64))
            Text(title)
                .font(.title2).bold()
                .foregroundColor(Color.theme.text.main)
            
            Button {
                isPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Create")
                }
                .font(.headline)
                .padding(.vertical, 15)
                .padding(.horizontal, 55)
                .foregroundColor(Color.theme.text.second)
                .background(Color.theme.other.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    EmptyListView(emodji: "📆",
                  title: "Add your first note",
                  isPresented: .constant(true))
}
