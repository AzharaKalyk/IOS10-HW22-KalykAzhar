import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDetailView(model: Users) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func createMainView() -> UIViewController {
        let dataManager = CoreData()
        let view = UsersViewController()
        let presenter = Presenter(view: view, dataManager: dataManager)
        view.presenter = presenter
        return view
    }
    
    static func createDetailView(model: Users) -> UIViewController {
        let dataManager = CoreData()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, user: model)
        view.presenter = presenter
        return view
    }
}

