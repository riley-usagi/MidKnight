import CoreData
import SwiftUI

struct Target: Identifiable {
  
  var id: String = UUID().uuidString
  var name: String = ""
  var currentValue: Int = 0
  var targetValue: Int = 77
}

extension Target {
  
  init?(managedObject: TargetsModelObject) {
    
    self.init(
      id: managedObject.id ?? "",
      name: managedObject.name ?? "",
      currentValue: Int(managedObject.currentValue),
      targetValue: Int(managedObject.targetValue)
    )
  }
}


extension Target {
  
  @discardableResult
  func modelToObjectWithin(_ context: NSManagedObjectContext) -> TargetsModelObject? {
    
    guard let targetModelObject = TargetsModelObject.insertNew(in: context) else { return nil }
    
    targetModelObject.id            = id
    targetModelObject.name          = name
    targetModelObject.currentValue  = Int32(currentValue)
    targetModelObject.targetValue   = Int32(targetValue)
    
    return targetModelObject
  }
}

#warning("Как-нибудь вынести это дело в подобающее место")
extension Target {
  
  func updateTarget(
    in context: NSManagedObjectContext,
    id: String,
    currentValue: Int
  ) -> TargetsModelObject? {
    
    let fetchRequest =
      NSFetchRequest<NSFetchRequestResult>(entityName: "TargetsModelObject")
    
    let idPredicate = NSPredicate(format: "id = %@", id)
    
    fetchRequest.predicate  = idPredicate
    fetchRequest.fetchLimit = 1
    
    let results = try? context.fetch(fetchRequest)
    
    let target = results?[0] as! TargetsModelObject
    
    let newCurrentValue = target.currentValue + Int32(currentValue)
    
    target.setValue(Int32(newCurrentValue), forKey: "currentValue")
    
    return target
  }
}
