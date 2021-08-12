import Combine

protocol TargetsInteractor {
  func targetsFromCoreData(targets: LoadableSubject<LazyList<Target>>)
  
  func createTarget(_ name: String) -> AnyPublisher<Bool, Error>
  
  func updateTarget(_ target: Target) -> AnyPublisher<Bool, Error>
}

struct RealTargetsInteractor: TargetsInteractor {
  
  let dbServise: CoreDataServise
  
  init(dbServise: CoreDataServise) {
    self.dbServise = dbServise
  }
  
  func targetsFromCoreData(targets: LoadableSubject<LazyList<Target>>) {
    
    let cancelBag = CancelBag()
    
    targets.wrappedValue.setIsLoading(cancelBag: cancelBag)
    
    Just<Void>
      .withErrorType(Error.self)
      
      .flatMap { [dbServise] in
        dbServise.targetsFromCoreData()
      }
      
      .sinkToLoadable { loadedTargets in
        targets.wrappedValue = loadedTargets
      }
      
      .store(in: cancelBag)
  }

  func createTarget(_ name: String) -> AnyPublisher<Bool, Error> {
    
    let newTarget: Target = Target(name: name)
    
    return dbServise
      .saveDataToCoreData(targets: [newTarget])
      .eraseToAnyPublisher()
  }
  
  func updateTarget(_ target: Target) -> AnyPublisher<Bool, Error> {
    dbServise
      .updateTarget(target: target, newCurrentValue: 11)
  }
}

struct StubTargetsInteractor: TargetsInteractor {
  
  func targetsFromCoreData(targets: LoadableSubject<LazyList<Target>>) {}
  
  func createTarget(_ name: String) -> AnyPublisher<Bool, Error> {
    Just<Bool>.withErrorType(false, Error.self)
      .eraseToAnyPublisher()
  }
  
  func updateTarget(_ target: Target) -> AnyPublisher<Bool, Error> {
    Just<Bool>.withErrorType(false, Error.self)
      .eraseToAnyPublisher()
  }
}
