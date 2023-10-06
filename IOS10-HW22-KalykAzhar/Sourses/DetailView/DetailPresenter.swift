import Foundation

final class DetailPresenter: DetailViewInput {
    weak var view: DetailViewOutput?
    private var user: Users?
    
    init(view: DetailViewOutput, user: Users) {
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
    }
}
