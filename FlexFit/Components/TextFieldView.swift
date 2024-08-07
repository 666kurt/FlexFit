import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var queryText: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if queryText.isEmpty {
                Text(placeholder)
                    .font(.callout)
                    .foregroundColor(Color.theme.text.notActive)
            }
            TextField("", text: $queryText)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12.5)
        .foregroundColor(Color.theme.text.main)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.theme.other.primary, lineWidth: 2)
        )
        .background(Color.theme.background.main)
    }
}

#Preview {
    TextFieldView(placeholder: "Enter note",
                  queryText: .constant(""))
    .padding()
}
