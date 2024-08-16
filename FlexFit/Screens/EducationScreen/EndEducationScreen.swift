import SwiftUI

struct EndEducationScreen: View {
    
    @Binding var showOnboarding: Bool
    
    var body: some View {
        
        VStack(spacing: 120) {
            Text("Thank you for\nchoosing us! ")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(Color.theme.text.main)
                .multilineTextAlignment(.center)
                .padding(.top, 100)
            
            VStack(spacing: 33) {
                Text("Train for fun and we'll\nhelp you out ")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.text.main)
                    .multilineTextAlignment(.center)
                
                Button {
                    showOnboarding = false
                    UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                } label: {
                    Text("Start using")
                        .fontWeight(.semibold)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 80)
                        .background(Color.theme.other.primary)
                        .foregroundColor(Color.theme.text.second)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(hex: "#020C1E").ignoresSafeArea())
    }
}

#Preview {
    EndEducationScreen(showOnboarding: .constant(false))
}
