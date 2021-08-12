import SwiftUI

struct ContentView: View {
  
  private let container: Container
  
  var body: some View {
    TodayScreen()
//    NewDayScreen(displayStatus: .constant(true))
//    SettingsScreen(displayStatus: .constant(true))
      .inject(container)
  }
  
  
  // MARK: - Initializers
  
  init(container: Container) {
    self.container = container
  }
}
