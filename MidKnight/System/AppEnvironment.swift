/// Объект окружения
struct AppEnvironment {
  
  /// Контейнер зависимостей
  let container: Container
}

// MARK: - Bootstrap method
extension AppEnvironment {
  
  static func bootstrap() -> AppEnvironment {
    
    /// Хранилище состояний
    let appState    = Store<AppState>(AppState())
    
    let dbServices  = configuredCoreDataServices()
    
    /// Контейнер с интеракторами
    let interactors = configuredInteractors(
      dbServices: dbServices, appState: appState
    )
    
    /// Контейнер с зависимостями
    let container   = Container(appState: appState, interactors: interactors)
    
    return AppEnvironment(container: container)
  }
}
