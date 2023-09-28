import Foundation
import CoreData

protocol UsersView: AnyObject {
    func reloadData()
}

protocol UsersPresenterProtocol {
    init (view: UsersView)
    func addNewUser(name: String)
    func fetchUsers()
    func getUsersCount() -> Int
    func getUser(index: Int) -> Users?
    func deleteUser(index: Int)
}
