import SwiftUI

struct CalendarScreen: View {
    @EnvironmentObject private var viewModel: CalendarViewModel
    @State private var showNewNote: Bool = false
    @State private var showAlert: Bool = false
    @State private var indexSetToDelete: IndexSet?
    
    private let colunms: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                WeekCalendarView(selectedDate: $viewModel.selectedDate)
                    .onChange(of: viewModel.selectedDate) { _ in
                        viewModel.fetchNotes(for: viewModel.selectedDate)
                    }
                
                if viewModel.notesForSelectedDate.isEmpty {
                        EmptyListView(emodji: "📆",
                                      title: "Add your first note",
                                      isPresented: $showNewNote)
                } else {
                    listNotesView
                }
            }
            .padding(.horizontal, 20)
            .background(Color.theme.background.main.ignoresSafeArea())
            .fullScreenCover(isPresented: $showNewNote) {
                NewNoteView()
                    .environmentObject(viewModel)
            }
            .onAppear {
                viewModel.fetchNotes(for: viewModel.selectedDate)
            }
            
            if showAlert {
                AlertView(showAlert: $showAlert,
                          title: "Delete",
                          description: "Are you sure you want to delete?",
                          onDelete: {
                    if let indexSet = indexSetToDelete {
                        viewModel.deleteNotes(at: indexSet)
                        indexSetToDelete = nil
                    }
                })
                .transition(.opacity)
                .animation(.easeInOut)
            }
        }
    }
    
}

extension CalendarScreen {
    private var listNotesView: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: colunms) {
                    ForEach(viewModel.notesForSelectedDate, id: \.id) { note in
                        NoteRowView(note: note)
                            .environmentObject(viewModel)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }
            
            NewButtonView(buttonLabel: "New note",
                          isPresented: $showNewNote)
        }
    }
}

#Preview {
    CalendarScreen()
        .environmentObject(CalendarViewModel())
}
