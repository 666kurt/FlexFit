import SwiftUI

struct Settings: Identifiable {
    let id = UUID().uuidString
    let image: String
    let title: String
    let url: String
}

struct SettingsScreen: View {
    
    private let settings: [Settings] = [
        Settings(image: "bubble.fill", 
                 title: "Contact us",
                 url: "https://www.termsfeed.com/live/0462b8bc-40c7-4b53-867a-3cd2286eb9c0"),
        Settings(image: "menucard.fill",
                 title: "Terms of use",
                 url: "https://www.termsfeed.com/live/0462b8bc-40c7-4b53-867a-3cd2286eb9c0"),
        Settings(image: "shield.fill",
                 title: "Privacy",
                 url: "https://www.termsfeed.com/live/13895a26-3e51-4a77-ad80-c8215a72311d")
    ]
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            NavigationTitleView(title: "Settings")
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(settings) { setting in
                        Link(destination: URL(string: setting.url)!, label: {
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
                        })
                    }
                }
                .padding(.horizontal, 16)
                .background(Color.theme.background.second)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            }
            
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.theme.background.main.ignoresSafeArea())
    }
}

#Preview {
    SettingsScreen()
}

