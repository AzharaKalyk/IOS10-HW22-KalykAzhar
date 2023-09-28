import Foundation

protocol DetailProtocolView: AnyObject {
    var user: Users? { get set }
    func updateUserInfo()
}

protocol DetailPresenterProtocol {
    init(view: DetailProtocolView, user: Users)
    func getUser()
    func updateUser(name: String?, date: Date?, gender: String?)
}
