import SwiftUI

struct OnboardingStepView: View {
    
    let image: String
    let titleImage: String
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Image(image)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            Image(titleImage)
                .padding(.top, 60)

        }
        
    }
}

#Preview {
    OnboardingStepView(image: "onboarding1",
                       titleImage: "onboardingText1")
}
