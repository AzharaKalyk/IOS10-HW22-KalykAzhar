import Foundation
import CoreData

extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var date: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}

extension Users : Identifiable {

}
