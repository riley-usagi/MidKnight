extension AppEnvironment {
  
  static func configuredInteractors(
    dbServices: Container.CDServises,
    appState: Store<AppState>
  ) -> Container.Interactors {
    
    let targetsInteractor = RealTargetsInteractor(dbServise: dbServices.coreDataServise)
    
    let moneyInteractor = RealMoneyInteractor(appState: appState)
    
    return .init(
      targetsInteractor: targetsInteractor,
      moneyInteractor: moneyInteractor
    )
  }
}
