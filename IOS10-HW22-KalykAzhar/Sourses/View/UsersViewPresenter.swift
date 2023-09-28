import Foundation

final class Presenter: UsersPresenterProtocol {
    
    weak var view: UsersView?
    
    init(view: UsersView) {
        self.view = view
    }
    
    func addNewUser(name: String) {
        CoreData.shared.addNewUser(name: name, gender: "", date: "")
        view?.reloadData()
    }
    
    func fetchUsers() {
        CoreData.shared.fetchUsers()
        view?.reloadData()
    }
    func getUsersCount() -> Int {
        CoreData.shared.users?.count ?? 0
    }
    
    func getUser(index: Int) -> Users? {
        CoreData.shared.users?[index]
    }
    
    func deleteUser(index: Int) {
        CoreData.shared.deleteUser(index: index)
        view?.reloadData()
    }
}
