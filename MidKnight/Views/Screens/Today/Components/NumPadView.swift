import SwiftUI

struct NumPadView: View {
  
  var rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "delete.left"]
  
  @Binding var value: String
  
  var body: some View {
    
    GeometryReader { reader in
      
      VStack {
        
        HStack(spacing: 10) {
          
          LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), spacing: 15) {
            
            ForEach(rows, id: \.self) { value in
              
              Button(action: { buttonAction(value: value) }) {
                
                ZStack {
                  
                  if value == "delete.left" {
                    Image(systemName: value)
                      .font(.title)
                      .foregroundColor(.black)
                  } else {
                    
                    Text(value)
                      .font(.title)
                      .fontWeight(.bold)
                      .foregroundColor(.black)
                  }
                }
                .frame(
                  width: getWidth(frame: reader.frame(in: .global)),
                  height: getHeight(frame: reader.frame(in: .global))
                )
                .background(Color.white)
                .cornerRadius(10)
              }
              .disabled(value == "" ? true : false)
            }
          }
        }
      }
    }
    .padding()
  }
}

private extension NumPadView {
  
  func getWidth(frame: CGRect) -> CGFloat {
    let width = frame.width
    
    let actualWidth = width - 40
    
    return actualWidth / 3
  }
  
  func getHeight(frame: CGRect) -> CGFloat {
    let height = frame.height
    
    let actualHeight = height - 40
    
    return actualHeight / 4
  }
  
  func buttonAction(value: String) {
    if value == "delete.left" && self.value != "" {
      
      if self.value.count > 1 {
        self.value.removeLast()
      } else {
        self.value = "0"
      }
    }
    
    if value != "delete.left" {
      

      
      if self.value.count < 6 {
        
        if self.value.first == "0" {
          self.value.removeFirst()
        }
        
        self.value.append(value)
      }
    }
  }
}
