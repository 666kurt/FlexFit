import SwiftUI

struct ScreenshotsView: View {
    @State private var currentIndex = 0
    @State private var showEndScreen = false
    private let images = ["edu1", "edu2", "edu3", "edu4", "edu5", "edu6"]
    @Binding var showOnboarding: Bool
    
    
    private let views: [AnyView] = [
        AnyView(MainView()),
        AnyView(TrainingScreen()),
        AnyView(CalendarScreen())
    ]
    
    var body: some View {
        ZStack {
            if showEndScreen {
                EndEducationScreen(showOnboarding: $showOnboarding)
            } else {
                GeometryReader { geometry in
                    Image(images[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color(hex: "#020C1E").ignoresSafeArea())
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.5), value: currentIndex)
                        .onAppear {
                            startScreenshots()
                        }
                }
            }
        }
    }

    func startScreenshots() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            if currentIndex < images.count - 1 {
                withAnimation {
                    currentIndex += 1
                }
            } else {
                timer.invalidate()
                showEndScreen = true
            }
        }
    }
}

#Preview {
    ScreenshotsView(showOnboarding: .constant(false))
}
