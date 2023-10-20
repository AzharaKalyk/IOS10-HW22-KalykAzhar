import Foundation

class DetailPresenter: DetailViewInput {
    
    weak var view: DetailViewOutput?
    var dataManager: CoreDataProtocol?
    var user: User
    
    required init(view: DetailViewOutput, dataManager: CoreDataProtocol, user: User) {
        self.view = view
        self.dataManager = dataManager
        self.user = user
    }
    
    func getUserData() {
        view?.setUserData(with: user)
    }
    
    func updateUser(_ user: User, completion: ((Bool) -> ())) {
        guard let dataManager = dataManager else {
            completion(false)
            return
        }
        
        dataManager.updateUser(user) { isSuccess in
            completion(isSuccess)
        }
    }
}
