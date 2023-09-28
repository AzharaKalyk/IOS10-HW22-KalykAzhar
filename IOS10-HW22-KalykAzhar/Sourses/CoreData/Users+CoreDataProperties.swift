import Foundation
import CoreData

extension Users {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var gender: String?
}

extension Users : Identifiable {
    
}
