import SwiftUI

struct AlertView: View {
    
    @Binding var showAlert: Bool
    let title: String
    let description: String
    let onReset: () -> Void
    
    var body: some View {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                Text(description)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                
                Divider()
                    .background(Color(hex: "#8C8C8C"))
                
                HStack {
                    
                    Button {
                        showAlert = false
                    } label: {
                        Text("Close")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.theme.other.primary)
                    }
                    
                    Divider()
                        .background(Color(hex: "#8C8C8C"))
                    
                    Button {
                        onReset()
                        showAlert = false
                    } label: {
                        Text("Delete")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color(hex: "#FF2424"))
                        
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
            }
            .foregroundColor(Color.theme.text.main)
            .zIndex(1)
            .frame(maxWidth: 270, alignment: .center)
            .background(
                Color(hex: "#252525")
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    AlertView(showAlert: .constant(true),
                    title: "Reset data",
                    description: "Do you really want to reset the data? It'll cause you to lose progress.") {
        //
    }
}
