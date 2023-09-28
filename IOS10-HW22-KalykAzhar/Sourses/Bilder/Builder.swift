import UIKit

protocol ModuleBuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDetailView(model: Users) -> UIViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    static func createMainView() -> UIViewController {
        let view = UsersViewController()
        let presenter = Presenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createDetailView(model: Users) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, user: model)
        view.presenter = presenter
        return view
    }
}

