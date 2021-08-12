import Foundation
import CoreData

@objc(TargetsModelObject)
public class TargetsModelObject: NSManagedObject {
  
  static func targetsList() -> NSFetchRequest<TargetsModelObject> {
    
    let request = newFetchRequest()
    
    request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    request.fetchBatchSize = 10
    
    return request
  }
}
