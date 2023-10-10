import Foundation

final class DetailPresenter: DetailViewInput {
    weak var view: DetailViewOutput?
    private var user: User?
    
    init(view: DetailViewOutput, user: User) {
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
        CoreData.shared.saveContext()
    }
}
