import SwiftUI

struct OnboardingStepView: View {
    
    let image: String
    let titleImage: String
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Image(image)
                .resizable()
                .ignoresSafeArea()
            
            Image(titleImage)
                .padding(.top, 35)

        }
        
    }
}

#Preview {
    OnboardingStepView(image: "onboarding1",
                       titleImage: "onboardingText1")
}
