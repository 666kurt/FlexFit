import SwiftUI

struct OnboardingScreen: View {
    
    @Binding var showOnboarding: Bool
    @State var showEducation: Bool = false
    @State private var currentTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                OnboardingStepView(image: "onboarding1",
                                   titleImage: "onboardingText1").tag(0)
                OnboardingStepView(image: "onboarding2",
                                   titleImage: "onboardingText2").tag(1)
                OnboardingStepView(image: "onboarding3",
                                   titleImage: "onboardingText3").tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                CustomTabIndicator(currentTab: $currentTab, numberOfTabs: 3)
                
                Button(action: {
                    if currentTab < 2 {
                        currentTab += 1
                    } else {
                        showEducation = true
//                        showOnboarding = false
//                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    }
                }, label: {
                    Text("Next")
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.theme.text.main)
                        .background(Color.theme.other.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                })
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .fullScreenCover(isPresented: $showEducation, content: {
            StartEducationScreen(showOnboarding: $showOnboarding)
        })
    }
}


#Preview {
    OnboardingScreen(showOnboarding: .constant(true), showEducation: false)
}
