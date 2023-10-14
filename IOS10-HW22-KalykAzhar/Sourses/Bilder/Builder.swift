import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDetailView(user: User) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func createMainView() -> UIViewController {
        let dataManager = CoreData()
        let view = UserViewController()
        let presenter = Presenter(view: view, dataManager: dataManager)
        view.presenter = presenter
        return view
    }
    
    static func createDetailView(user: User) -> UIViewController {
        let dataManager = CoreData()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, dataManager: dataManager, user: user)
        view.presenter = presenter
        view.user = user
        return view
    }
}

