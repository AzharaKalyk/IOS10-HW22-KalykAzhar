import Foundation

protocol DetailViewOutput: AnyObject {
    var user: Users? { get set }
    func updateUserInfo()
}

protocol DetailViewInput {
    init(view: DetailViewOutput, user: Users)
    func getUser()
    func updateUser(name: String?, date: Date?, gender: String?)
}
