import Foundation
import CoreData

protocol UsersViewOutput: AnyObject {
    func reloadData()
}

protocol UsersViewInput {
    init (view: UsersViewOutput, dataManager: CoreDataProtocol)
    func addNewUser(name: String)
    func fetchUsers()
    func getUsersCount() -> Int
    func getUser(_ index: Int) -> Users?
    func deleteUser(_ index: Int)
}
