extension AppEnvironment {
  
  static func configuredCoreDataServices() -> Container.CDServises {
    
    let persistentStore = CoreDataStack()
    
    let coreDataService = RealCoreDataService(persistentStore: persistentStore)
    
    return .init(coreDataServise: coreDataService)
  }
}
