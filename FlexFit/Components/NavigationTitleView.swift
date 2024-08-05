import SwiftUI

struct NavigationTitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.largeTitle).bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color.theme.text.main)
            .padding(.leading, 16)
    }
}

#Preview {
    NavigationTitleView(title: "My Calendar")
}