import Foundation
import CoreData

extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var gender: String?
}

extension User: Identifiable {
    
}
