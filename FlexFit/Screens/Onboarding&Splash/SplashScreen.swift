import SwiftUI

struct SplashScreen: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isActive: Bool = false
    @Binding var showOnboarding: Bool
    let persistenceController: PersistenceController
    
    var body: some View {
        ZStack {
            Image("splash")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 100) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                HStack(spacing: 8) {
                    
                    ProgressView(value: progress, total: 100)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    
                    Text("\(Int(progress))%")
                        .font(.body)
                        .foregroundColor(Color.theme.text.main)
                }
            }
        }
        .onAppear {
            startLoading()
        }
        .fullScreenCover(isPresented: $isActive) {
            if showOnboarding {
                OnboardingScreen(showOnboarding: $showOnboarding)
            } else {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
    
    func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if progress < 100 {
                progress += 5
            } else {
                timer.invalidate()
                isActive = true
            }
        }
    }
}

#Preview {
    SplashScreen(showOnboarding: .constant(true), persistenceController: PersistenceController.shared)
}
