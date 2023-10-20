import Foundation
import CoreData

protocol UserViewOutput: AnyObject {
    func updateUsers(_ users: [User])
    func reloadData()
}

protocol UserViewInput {
    init (view: UserViewOutput, dataManager: CoreDataProtocol)
    func fetchUsers()
    func addNewUser(name: String)
    func deleteUser(user: User)
    func getModelDataCount() -> Int
    func getContact(_ index: Int) -> User?
}

