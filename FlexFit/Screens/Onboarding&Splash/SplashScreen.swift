import SwiftUI

struct SplashScreen: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isActive: Bool = false
    @Binding var showOnboarding: Bool
    let persistenceController: PersistenceController
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("splash")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 50) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.3)
                    
                    HStack(spacing: 8) {
                        ProgressView(value: progress, total: 100)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5) // Adjust size if needed
                        
                        Text("\(Int(progress))%")
                            .font(.body)
                            .foregroundColor(Color.white)
                    }
                    .padding(.top, 20) // Adjust padding as needed
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
