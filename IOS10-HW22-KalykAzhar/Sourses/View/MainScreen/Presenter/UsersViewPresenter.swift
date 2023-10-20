import Foundation

class Presenter: UserViewInput {
    
    weak var view: UserViewOutput?
    let dataManager: CoreDataProtocol
    
    required init(view: UserViewOutput, dataManager: CoreDataProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func fetchUsers() {
        dataManager.fetchUsers()
        view?.updateUsers(dataManager.users ?? [])
    }
    
    func addNewUser(name: String) {
        dataManager.addNewUser(name: name)
        view?.reloadData()

    }
    
    func deleteUser(user: User) {
        dataManager.deleteUser(user: user)
        view?.reloadData()
    }
    
    func getModelDataCount() -> Int {
        return dataManager.users?.count ?? 0
    }
    
    func getContact(_ index: Int) -> User? {
        return dataManager.users?[index]
    }
}
