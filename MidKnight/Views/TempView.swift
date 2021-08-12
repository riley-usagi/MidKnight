import SwiftUI

struct TempView: View {
  @AppStorage("username") var username: String = "Anonymous"
  
  var body: some View {
    VStack {
      Text("Welcome, \(username)!")
      
      Button("Log in") {
        username = "@twostraws"
      }
    }
  }
}
