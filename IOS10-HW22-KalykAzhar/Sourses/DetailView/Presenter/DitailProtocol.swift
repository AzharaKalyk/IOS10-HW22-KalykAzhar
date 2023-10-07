import Foundation

protocol DetailViewOutput: AnyObject {
    var user: User? { get set }
    func updateUserInfo()
}

protocol DetailViewInput {
    init(view: DetailViewOutput, user: User)
    func getUser()
    func updateUser(name: String?, date: Date?, gender: String?)
}
