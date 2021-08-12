import SwiftUI

struct Container: EnvironmentKey {
 
  
  // MARK: - Tech variables
  static var defaultValue: Self { self.default }
  private static let `default` = Self(appState: AppState(), interactors: .stub)
  
  
  // MARK: - Variables
  
  var appState: Store<AppState>
  
  var interactors: Interactors
  
  
  // MARK: - Initializers
  init(appState: Store<AppState>, interactors: Interactors) {
    self.appState     = appState
    self.interactors  = interactors
  }
  
  init(appState: AppState, interactors: Interactors) {
    self.init(appState: Store<AppState>(appState), interactors: interactors)
  }
}


// MARK: - Environment Values
extension EnvironmentValues {
  
  var container: Container {
    get { self[Container.self] }
    set { self[Container.self] = newValue }
  }
}

// MARK: - View inject

extension View {
  
  func inject(_ appState: AppState, _ interactors: Container.Interactors) -> some View {
    let container = Container(appState: .init(appState), interactors: interactors)
    
    return inject(container)
  }
  
  
  /// Добавление главного контейнера в иерархию Экранов
  /// - Parameter container: Объект настроенного контейнера
  /// - Returns: Объект View
  func inject(_ container: Container) -> some View {
    return self
      .environment(\.container, container)
  }
}
