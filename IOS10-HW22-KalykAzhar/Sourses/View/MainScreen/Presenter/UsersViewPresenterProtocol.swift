import Foundation
import CoreData

protocol UserViewOutput: AnyObject {
    func reloadData()
}

protocol UserViewInput {
    init (view: UserViewOutput, dataManager: CoreDataProtocol)
    func addNewUser(name: String)
    func fetchUsers()
    func getUsersCount() -> Int
    func getUser(_ index: Int) -> User?
    func deleteUser(_ index: Int)
}
