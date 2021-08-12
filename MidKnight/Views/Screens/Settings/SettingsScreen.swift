import Combine
import SwiftUI

struct SettingsScreen: View {
  
  @Environment(\.container) private var container: Container

  @Binding var displayStatus: Bool
  
  /// Объект для форматирования даты
  let dateFormatter = DateFormatter()
  
  let arrayOfFourthDays: [Date] = Date.arrayOfFourthDays()
  
  @State private var selectedDayBeforePay: Int = 1
  
  @State private var tempTotalCash: String = "0"
  
  // MARK: - AppStorage
  @AppStorage("totalCash") var totalCash: Int = 0
  @AppStorage("daysBeforePay") var daysBeforePay: Int = 1
  
  
  // MARK: - Initializers
  init(displayStatus: Binding<Bool>) {
    dateFormatter.dateFormat  = "d MMM"
    dateFormatter.locale      = Locale(identifier: "ru_RU")
    self._displayStatus       = displayStatus
  }
  
  var body: some View {
    
    ZStack {
      
      VStack {
        
        VStack {

          
          // MARK: - Header
          HStack {
            Button(action: {
              
            }, label: {
              Image(systemName: "arrow.left")
                .font(.title2)
                .foregroundColor(.black)
            })
            
            Spacer()
            
            Text("Settings")
              .font(.title2)
              .fontWeight(.bold)
              .foregroundColor(.black)
            
            Spacer()
          }
          .padding()
          
          Text("Some settings")
            .foregroundColor(.gray)
            .padding(.bottom)
          
//          Spacer(minLength: 0)
          Divider()
          
          
          // MARK: - TotalCash
          HStack {
            
            Text("Total: ").font(.largeTitle)
            
            Text("\(totalCash)")
          }.padding()
          
          Divider()
          
          
          // MARK: - Per day cahs
          HStack {
            
            Text("Per day: ").font(.headline)

            Text("\(totalCash / daysBeforePay)")
          }.padding()
          
          Divider()
          
          Spacer()

          
          // MARK: - Pay Day Select
          
          HStack {
            
            // MARK: - Picker
            
            Picker(selection: $daysBeforePay, label: EmptyView()) {
              
              ForEach(Array(Date.arrayOfFourthDays().enumerated()), id: \.element) { index, item in
                
                HStack {
                  Text("\(self.dateFormatter.string(from: self.arrayOfFourthDays[index]))")
                  
                  Text("-")
                  
                  Text("\(index + 1)")

                  Text("\(Date.dayDeclension(dayNumber: index + 1))")
                }
                .tag(index + 1)
              }
            }
            .id(UUID())
            .pickerStyle(WheelPickerStyle())
    //        .onChange(of: selectedDayBeforePay, perform: { value in
    //          print(selectedDayBeforePay)
    //        })

            
          }.padding()
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .background(Color.white)
        .cornerRadius(20)
        
        #warning("Исправить")
         NumPadView(value: $tempTotalCash)
      }
      .background(
        Color("lightGray")
          .ignoresSafeArea(.all, edges: .bottom)
      )
    }
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
  }
}
