import Foundation

class DetailPresenter: DetailViewInput {
    weak var view: DetailViewOutput?
    var dataManager: CoreDataProtocol?
    var user: User?
    
    required init(view: DetailViewOutput, dataManager: CoreDataProtocol, user: User) {
        self.view = view
        self.dataManager = dataManager
        self.user = user
    }
    
    func setContact() {
        view?.user = user ?? User()
    }
    
    func updateName(item: User, newName: String) {
        print("update name: \(newName)")
        user?.name = newName
        dataManager?.updateName(item: item, newName: newName)
        dataManager?.fetchUsers()
    }
    
    func updateGender(item: User, newGender: String) {
        user?.gender = newGender
        dataManager?.fetchUsers()
    }
    
    func updateDate(item: User, newDate: Date) {
        user?.date = newDate
        dataManager?.fetchUsers()
    }
}
