import SwiftUI

struct TodayScreen: View {
  
  @Environment(\.container) private var container: Container
  
  @State private var newDayStatus = false
  
  @AppStorage("todayCash") private var todayCash: String = ""
  
  @State private var spendedMoney: String = "0"
  
  @State private var settingsScreenViewStatus: Bool = false
  
  var body: some View {
    content
      .fullScreenCover(isPresented: $newDayStatus, content: {
        NewDayScreen(displayStatus: $newDayStatus)
      })
  }
}

private extension TodayScreen {
  
  var content: some View {
    
    ZStack {
      
      VStack {
        
        VStack {
          
          HStack {
            Button(action: {}, label: {
              Image(systemName: "archivebox")
                .font(.title2)
                .foregroundColor(.black)
            })
            
            Spacer()
            
            Text("Today Cash")
              .font(.title2)
              .fontWeight(.bold)
              .foregroundColor(.black)
            
            Spacer()
            
            Button(action: {
              settingsScreenViewStatus.toggle()
            }, label: {
              Image(systemName: "gear")
                .font(.title2)
                .foregroundColor(.black)
            })
          }
          .padding()
          
          Text("Money for Today")
            .foregroundColor(.gray)
            .padding(.bottom)
          
          Spacer(minLength: 0)
          
          HStack(spacing: 15) {
            
            ForEach(0..<6, id: \.self) { index in
              CodeView(code: getCodeAtIndex(index: index))
            }
          }
          .padding()
          .padding(.horizontal, 20)
          
          Spacer(minLength: 0)
          
          HStack(spacing: 6) {
            Text("Just keep spending even if today cash is about zero")
              .font(.title3)
              .foregroundColor(.gray)
              .multilineTextAlignment(.center)
          }
          .padding()
          
          HStack {
            VStack {
              
              Text("Let's spend some money")
                .font(.caption)
                .foregroundColor(.gray)
              
              Text(spendedMoney)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(minHeight: 30)
            }
            .padding()
            
            Spacer(minLength: 0)
            
            Button(action: {
              container.interactors.moneyInteractor.spendSomeMoney(value: spendedMoney)
              
              spendedMoney = "0"
            }, label: {
              Text("Spend")
                .foregroundColor(.black)
                .padding(.vertical, 18)
                .padding(.horizontal, 38)
                .background(Color.yellow)
                .cornerRadius(15)
            })
          }
          .padding()
          .background(Color.white)
          .cornerRadius(20)
          .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
          
        }
        .frame(height: UIScreen.main.bounds.height / 1.8)
        .background(Color.white)
        .cornerRadius(20)
        
        NumPadView(value: $spendedMoney)
      }
      .background(
        Color("lightGray")
          .ignoresSafeArea(.all, edges: .bottom)
      )
    }
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    .fullScreenCover(isPresented: $settingsScreenViewStatus, content: {
      SettingsScreen(displayStatus: $settingsScreenViewStatus)
    })
  }
}

extension TodayScreen {
  func getCodeAtIndex(index: Int) -> String {
    
    
    #warning("Реализовать отображение с правой стороны экрана, а не с левой")
    if todayCash.count > index {
      
      let start = todayCash.startIndex
      
      let current = todayCash.index(start, offsetBy: index)
      
      return String(todayCash[current])
    }
    
    return ""
  }
}
