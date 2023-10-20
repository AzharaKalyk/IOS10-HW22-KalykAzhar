import Foundation

protocol CoreDataProtocol {
    var users: [User]? { get set }
    func fetchUsers()
    func addNewUser(name: String)
    func deleteUser(user: User)
    func updateUser(_ user: User, completion: ((Bool) -> ()))
    func saveContext()
}

