import Foundation

class Presenter: UserViewInput {
    
    weak var view: UserViewOutput?
    let dataManager: CoreDataProtocol
    
    required init(view: UserViewOutput, dataManager: CoreDataProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func addNewUser(name: String) {
        dataManager.addNewUser(name: name)
        view?.reloadData()
    }
    
    func fetchUsers() {
        dataManager.fetchUsers()
        if let users = dataManager.getUsers() {
            view?.users = users
            view?.reloadData()
        }
    }
    
    func getUsersCount() -> Int {
        dataManager.models?.count ?? 0
    }
    
    func getUser(_ index: Int) -> User? {
        return dataManager.models?[index]
    }
    
    func deleteUser(_ index: Int) {
        dataManager.deleteUser(index: index)
        view?.reloadData()
    }
    
    func getUsers() -> [User] {
        return dataManager.getUsers() ?? []
    }
}
