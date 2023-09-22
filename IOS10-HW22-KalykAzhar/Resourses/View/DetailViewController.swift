import UIKit
import CoreData

// MARK: -DetailViewController

class DetailViewController: UIViewController {
    
    // MARK: - Elements
    
    private var isEditUser = false
    private let presenter = Presenter()
    
    private lazy var editButton: UIButton = {
        var editButton = UIButton()
        editButton.addTarget(self, action: #selector(editUser), for: .touchUpInside)
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.layer.cornerRadius = 10
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.backgroundColor = .white
        return editButton
    }()
        
    private lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.layer.cornerRadius = 100
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "Patrick")
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    private lazy var userIcon: UIImageView = {
        let userIcon = UIImageView()
        userIcon.image = UIImage(systemName: "person")
        userIcon.translatesAutoresizingMaskIntoConstraints = false
        return userIcon
    }()
    
    private lazy var userName: UITextField = {
        let userName = UITextField()
        userName.isEnabled = false
        userName.layer.cornerRadius = 8
        userName.borderStyle = .roundedRect
        userName.layer.borderWidth = 1
        userName.layer.borderColor = UIColor.black.cgColor
        userName.placeholder = "Enter your name..."
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    
    private lazy var calendarIcon: UIImageView = {
        let calendarIcon = UIImageView()
        calendarIcon.image = UIImage(systemName: "calendar")
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        return calendarIcon
    }()
    
    private lazy var calendarTextField: UITextField = {
        let calendarTextField = UITextField()
        calendarTextField.isEnabled = false
        calendarTextField.layer.cornerRadius = 8
        calendarTextField.borderStyle = .roundedRect
        calendarTextField.layer.borderWidth = 1
        calendarTextField.layer.borderColor = UIColor.black.cgColor
        calendarTextField.placeholder = "DD.MM.YYYY"
        calendarTextField.translatesAutoresizingMaskIntoConstraints = false
        return calendarTextField
    }()
    
    private lazy var genderIcon: UIImageView = {
        let genderIcon = UIImageView()
        genderIcon.image = UIImage(systemName: "person.2.circle")
        genderIcon.translatesAutoresizingMaskIntoConstraints = false
        return genderIcon
    }()
    
    private lazy var genderTextField: UITextField = {
        let genderTextField = UITextField()
        genderTextField.isEnabled = false
        genderTextField.layer.cornerRadius = 8
        genderTextField.borderStyle = .roundedRect
        genderTextField.layer.borderWidth = 1
        genderTextField.layer.borderColor = UIColor.black.cgColor
        genderTextField.placeholder = "Gender"
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        return genderTextField
    }()
    
    var person: Users? {
        didSet {
            userName.text = person?.name
            calendarTextField.text = person?.date
            genderTextField.text = person?.gender
        }
    }
    
    @objc func editUser() {
        if isEditUser {
            userName.isEnabled = false
            calendarTextField.isEnabled = false
            genderTextField.isEnabled = false
            editButton.setTitle("Edit", for: .normal)
            person?.name = userName.text
            person?.date = calendarTextField.text
            person?.gender = genderTextField.text
            presenter.updateItem()
        } else {
            userName.isEnabled = true
            calendarTextField.isEnabled = true
            genderTextField.isEnabled = true
            editButton.setTitle("Save", for: .normal)
        }
        isEditUser.toggle()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        setupHirarchy()
        setupLayout()
    }

    // MARK: -Setup
    
    func setupHirarchy() {
        view.addSubview(userImage)
        view.addSubview(userIcon)
        view.addSubview(userName)
        view.addSubview(calendarIcon)
        view.addSubview(calendarTextField)
        view.addSubview(genderIcon)
        view.addSubview(genderTextField)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            editButton.widthAnchor.constraint(equalToConstant: 120),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            
            userImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 95),
            userImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -95),
            userImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -450),
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            
            userIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            userIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 455),
            userIcon.rightAnchor.constraint(equalTo: userName.rightAnchor, constant: -275),
            userIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -375),
            userIcon.widthAnchor.constraint(equalToConstant: 15),
            userIcon.heightAnchor.constraint(equalToConstant: 15),
            
            userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            userName.topAnchor.constraint(equalTo: view.topAnchor, constant: 450),
            userName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            userName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -370),
            
            calendarIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            calendarIcon.topAnchor.constraint(equalTo: userName.topAnchor, constant: 55),
            calendarIcon.rightAnchor.constraint(equalTo: userName.rightAnchor, constant: -275),
            calendarIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -325),
            calendarIcon.widthAnchor.constraint(equalToConstant: 15),
            calendarIcon.heightAnchor.constraint(equalToConstant: 15),
            
            calendarTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            calendarTextField.topAnchor.constraint(equalTo: userName.topAnchor, constant: 50),
            calendarTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            calendarTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -320),
            
            genderIcon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 45),
            genderIcon.topAnchor.constraint(equalTo: calendarTextField.topAnchor, constant: 55),
            genderIcon.rightAnchor.constraint(equalTo: calendarTextField.rightAnchor, constant: -275),
            genderIcon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -275),
            genderIcon.widthAnchor.constraint(equalToConstant: 15),
            genderIcon.heightAnchor.constraint(equalToConstant: 15),
            
            genderTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            genderTextField.topAnchor.constraint(equalTo: calendarTextField.topAnchor, constant: 50),
            genderTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            genderTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -270),
        ])
    }
}
