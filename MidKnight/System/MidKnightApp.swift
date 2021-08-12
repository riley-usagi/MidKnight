import SwiftUI

@main struct MidKnightApp: App {
  
  var environment: AppEnvironment
  
  var body: some Scene {
    WindowGroup {
      ContentView(container: environment.container)
    }
  }
  
  init() {
    self.environment = AppEnvironment.bootstrap()
  }
}
