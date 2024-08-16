import SwiftUI

struct StartEducationScreen: View {
    @State private var showScreenshots = false
    @Binding var showOnboarding: Bool

    var body: some View {
        VStack(spacing: 120) {
            Text("Welcome to\nFlex Fit")
                .font(.largeTitle.weight(.bold))
                .foregroundColor(Color.theme.text.main)
                .multilineTextAlignment(.center)
                .padding(.top, 100)
            
            VStack(spacing: 33) {
                Text("Let's go through a\nshort tutorial to get to\nknow the app better")
                    .font(.largeTitle)
                    .foregroundColor(Color.theme.text.main)
                    .multilineTextAlignment(.center)
                
                Button {
                    showScreenshots = true
                } label: {
                    Text("Let's get started")
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
        .fullScreenCover(isPresented: $showScreenshots) {
            ScreenshotsView(showOnboarding: $showOnboarding)
        }
    }
}

#Preview {
    StartEducationScreen(showOnboarding: .constant(false))
}
