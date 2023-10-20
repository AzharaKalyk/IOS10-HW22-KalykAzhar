import Foundation

protocol DetailViewOutput: AnyObject {
    func setUserData(with user: User)
}

protocol DetailViewInput {
    init(view: DetailViewOutput, dataManager: CoreDataProtocol, user: User)
    
    func getUserData()
    func updateUser(_ user: User, completion: ((Bool) -> ()))
}
