import SwiftUI

struct CustomTabIndicator: View {
    @Binding var currentTab: Int
    var numberOfTabs: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfTabs, id: \.self) { index in
                if index == currentTab {
                    Capsule()
                        .fill(Color.theme.text.main)
                        .frame(width: 8, height: 8)
                } else {
                    Circle()
                        .fill(Color.theme.text.notActive)
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}

#Preview {
    CustomTabIndicator(currentTab: .constant(1), numberOfTabs: 3)
}
