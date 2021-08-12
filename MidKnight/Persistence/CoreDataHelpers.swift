import Combine
import CoreData

// MARK: - ManagedEntity

protocol ManagedEntity: NSFetchRequestResult { }

extension ManagedEntity where Self: NSManagedObject {
  
  static var entityName: String {
    return String(describing: Self.self)
  }
  
  static func insertNew(in context: NSManagedObjectContext) -> Self? {
    return NSEntityDescription
      .insertNewObject(forEntityName: entityName, into: context) as? Self
  }
  
  static func newFetchRequest() -> NSFetchRequest<Self> {
    return .init(entityName: entityName)
  }
}

// MARK: - NSManagedObjectContext

extension NSManagedObjectContext {
  
  func configureAsReadOnlyContext() {
    automaticallyMergesChangesFromParent = true
    mergePolicy = NSRollbackMergePolicy
    undoManager = nil
    shouldDeleteInaccessibleFaults = true
  }
}
