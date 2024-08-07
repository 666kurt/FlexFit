import SwiftUI

struct Settings: Identifiable {
    let id = UUID().uuidString
    let image: String
    let title: String
}

struct SettingsScreen: View {
    
    private let settings: [Settings] = [
        Settings(image: "bubble.fill", title: "Contact us"),
        Settings(image: "wallet.pass.fill", title: "License"),
        Settings(image: "menucard.fill", title: "Terms of use"),
        Settings(image: "shield.fill", title: "Privacy")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            
            NavigationTitleView(title: "Settings")
            
            VStack(alignment: .leading) {
                ForEach(settings) { setting in
                    VStack(spacing: 0) {
                        HStack(spacing: 12) {
                            Image(systemName: setting.image)
                                .frame(width: 28)
                                .foregroundColor(Color.theme.other.primary)
                            Text(setting.title)
                                .foregroundColor(Color.theme.text.main)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.theme.other.primary)
                                .font(.title3)
                        }
                        .padding(.vertical, 20)

                    }
                }
            }
            .padding(.horizontal, 16)
            .background(Color.theme.background.second)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.theme.background.main.ignoresSafeArea())
    }
}

#Preview {
    SettingsScreen()
}

