
import Foundation

protocol CoreDataProtocol {
    var models: [Users]? { get set}
    func fetchUsers()
    func addNewUser(name: String)
    func deleteUser(index: Int)
    func updateName(item: Users, newName: String)
    func updateGender(item: Users, newGender: String)
    func updateDate(item: Users, newDate: Date)
}
