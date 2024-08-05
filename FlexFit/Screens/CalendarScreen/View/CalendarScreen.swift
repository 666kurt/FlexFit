import SwiftUI

struct CalendarScreen: View {
    
    @StateObject private var viewModel = NoteViewModel()
    
    @State var selectedDate: Date = Date()
    @State var showNewNote: Bool = false
    @State var showAlert: Bool = false
    @State private var indexSetToDelete: IndexSet?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    
                    NavigationTitleView(title: "My Calendar")
                    
                    WeekCalendarView(currentDate: $selectedDate)
                    
                    // ЕСЛИ ЗАМЕТОК НЕТ
                    EmptyListView(emodji: "📆",
                                  title: "Add your first note",
                                  isPresented: $showNewNote)
                    
                    // ЕСЛИ ЗАМЕТКИ ЕСТЬ
//                    listNotesView
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.theme.background.main
                        .ignoresSafeArea()
                )
                .fullScreenCover(isPresented: $showNewNote) {
                    NewNoteView()
                }
                
                if showAlert {
                    alertOverlay
                }
            }
            
        }
    }
}

extension CalendarScreen {
    
    private var listNotesView: some View {
        ZStack(alignment: .bottom) {
            List {
                ForEach(1...5, id: \.self) { _ in
                    NoteRowView(noteLabel: "Test",
                                noteTime: Date())
                }
                .onDelete(perform: showDeleteAlert)
                .listRowBackground(Color.theme.background.main)
                .listRowInsets(EdgeInsets())
                
            }
            .listStyle(.plain)
            
            NewButtonView(buttonLabel: "New note", isPresented: $showNewNote)
        }
    }
    
    private var alertOverlay: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            AlertView(showAlert: $showAlert,
                      title: "Delete",
                      description: "Are you sure you want to delete?",
                      onReset: {
                if let indexSet = indexSetToDelete {
                    print(indexSet)
                }
            })
            .transition(.opacity)
            .animation(.easeInOut)
        }
    }
    
    private func showDeleteAlert(at indexSet: IndexSet) {
        indexSetToDelete = indexSet
        showAlert = true
    }
    
}

#Preview {
    CalendarScreen()
}
