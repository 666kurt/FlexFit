import SwiftUI

struct CalendarScreen: View {
    
    @State var selectedDate: Date = Date()
    @State var showNewNote: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                NavigationTitleView(title: "My Calendar")
                
                WeekCalendarView(currentDate: $selectedDate)
                
                

//                    VStack(spacing: 14) {
//                        Text("📆")
//                            .font(.system(size: 64))
//                        Text("Add your first note")
//                            .font(.title2).bold()
//                            .foregroundColor(Color.theme.text.main)
//                        
//                        CreateButtonView(isPresented: $showNewNote)
//                        
//                    }
//                    .frame(maxHeight: .infinity)

                    List {
                        ForEach(1...10, id: \.self) { _ in
                            NoteRowView(noteLabel: "Test",
                                        noteTime: Date())
                        }
                        .onDelete(perform: { indexSet in
                            print(indexSet)
                        })
                        .listRowBackground(Color.theme.background.main)
                        .listRowInsets(EdgeInsets())

                    }
                    .listStyle(.plain)
  

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.theme.background.main
                    .ignoresSafeArea()
            )
            .fullScreenCover(isPresented: $showNewNote) {
                NewNoteView()
            }

        }
    }
}

#Preview {
    CalendarScreen()
}
