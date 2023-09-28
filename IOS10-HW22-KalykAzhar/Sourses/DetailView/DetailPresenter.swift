import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailProtocolView?
    private var user: Users?
    
    init(view: DetailProtocolView, user: Users) {
        self.view = view
        self.user = user
    }
    
    func getUser() {
        view?.user = user
    }
    
    func updateUser(name: String?, date: Date?, gender: String?) {
        user?.name = name
        user?.gender = gender
        user?.date = date
        CoreData.shared.updateUser()
    }
}
