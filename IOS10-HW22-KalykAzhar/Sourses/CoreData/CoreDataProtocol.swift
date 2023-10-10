
import Foundation

protocol CoreDataProtocol {
    var models: [User]? { get set}
    func fetchUsers()
    func addNewUser(name: String)
    func deleteUser(index: Int)
    func updateName(item: User, newName: String)
    func updateGender(item: User, newGender: String)
    func updateDate(item: User, newDate: Date)
    func getUsers() -> [User]?
}
