import CoreData
import Combine

protocol CoreDataServise {
  
  func targetsFromCoreData() -> AnyPublisher<LazyList<Target>, Error>
  
  func saveDataToCoreData(targets: [Target]) -> AnyPublisher<Bool, Error>
  
  func updateTarget(target: Target, newCurrentValue: Int) -> AnyPublisher<Bool, Error>
}

struct RealCoreDataService: CoreDataServise {
  
  let persistentStore: PersistentStore
  
  func targetsFromCoreData() -> AnyPublisher<LazyList<Target>, Error> {
    
    let fetchRequest = TargetsModelObject.targetsList()
    
    return persistentStore
      .fetch(fetchRequest) { fetchedModelObject in
        Target(managedObject: fetchedModelObject)
      }
      .eraseToAnyPublisher()
  }
  
  func saveDataToCoreData(targets: [Target]) -> AnyPublisher<Bool, Error> {
    return persistentStore
      .update { context in
        targets.forEach { target in
          target.modelToObjectWithin(context)
        }
      }
      .flatMap { result -> AnyPublisher<Bool, Error> in
        return Just<Bool>.withErrorType(true, Error.self)
      }
      .eraseToAnyPublisher()
  }
  
  func updateTarget(target: Target, newCurrentValue: Int) -> AnyPublisher<Bool, Error> {
    
    return persistentStore
      .update { context in
        target.updateTarget(in: context, id: target.id, currentValue: newCurrentValue)
      }
      .map { updatedTargetModelObject -> Bool in
        if updatedTargetModelObject != nil {
          return true
        }
        
        return false
      }
      .eraseToAnyPublisher()
  }
}
