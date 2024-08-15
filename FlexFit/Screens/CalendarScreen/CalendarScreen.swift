import SwiftUI

struct CalendarScreen: View {
    @EnvironmentObject private var viewModel: CalendarViewModel
    @State private var showNewNote: Bool = false
    @State private var showAlert: Bool = false
    @State private var indexSetToDelete: IndexSet?
    
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
            List {
                ForEach(viewModel.notesForSelectedDate, id: \.id) { note in
                    NoteRowView(note: note)
                        .environmentObject(viewModel)
                }
                .onDelete { indexSet in
                    showAlert = true
                    indexSetToDelete = indexSet
                }
                .listRowBackground(Color.theme.background.main)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            
            NewButtonView(buttonLabel: "New note",
                          isPresented: $showNewNote)
        }
    }
}

#Preview {
    CalendarScreen()
        .environmentObject(CalendarViewModel())
}
