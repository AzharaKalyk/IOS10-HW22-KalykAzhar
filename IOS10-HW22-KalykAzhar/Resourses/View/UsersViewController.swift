import UIKit
import CoreData

class UsersViewController: UIViewController {
    
    // MARK: - Elements
    
    let presenter = Presenter()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 15
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray4
        textField.placeholder = "Print your name here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemBlue
        button.setTitle("Press", for: .normal)
        button.addTarget(self, action: #selector(addToTextField), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getAllItems()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        presenter.getAllItems()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    func setupHierarchy() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.topAnchor, constant: 70),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: button.topAnchor, constant: 100),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK:  - Actions
    
    @objc func addToTextField() {
        guard let text = textField.text, ((textField.text?.isEmpty) != nil) else {
            return
        }
        self.presenter.createItem(name: text)
        textField.text = ""
        tableView.reloadData()
    }
}
