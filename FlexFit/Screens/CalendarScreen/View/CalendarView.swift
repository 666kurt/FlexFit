import SwiftUI

struct WeekCalendarView: View {
    @Binding var currentDate: Date
    
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                let calendar = Calendar.current
                let startOfWeek = self.startOfWeek(self.currentDate)
                let date = calendar.date(byAdding: .day, value: index, to: startOfWeek)!
                
                VStack {
                    Text(self.dayOfWeekShortName(for: date))
                        .foregroundColor(.gray)
                        .padding(.bottom, 3)
                    
                    Text("\(calendar.component(.day, from: date))")
                        .foregroundColor(calendar.isDate(self.currentDate, inSameDayAs: date) ? .white : .white)
                        .padding(10)
                        .background(calendar.isDate(self.currentDate, inSameDayAs: date) ? Color.blue : Color.clear)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    self.currentDate = date
                }
            }
        }
        .padding(.vertical, 18)
        .onAppear {
            self.currentDate = Date()
        }
    }
    
    // Функция для получения начала недели
    func startOfWeek(_ date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: components)!
    }
    
    // Функция для получения короткого названия дня недели
    func dayOfWeekShortName(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        let shortName = formatter.string(from: date)
        return String(shortName.prefix(1))
    }
}

#Preview {
    WeekCalendarView(currentDate: .constant(Date()))
}
