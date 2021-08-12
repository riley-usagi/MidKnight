import CoreData
import Foundation

extension TargetsModelObject {
  @NSManaged public var id: String?
  @NSManaged public var name: String?
  @NSManaged public var currentValue: Int32
  @NSManaged public var targetValue: Int32
}

extension TargetsModelObject: Identifiable {}
extension TargetsModelObject: ManagedEntity {}
