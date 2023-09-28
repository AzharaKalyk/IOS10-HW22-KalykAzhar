import UIKit

// MARK: -DetailViewController

class DetailViewController: UIViewController, DetailProtocolView {
    
    // MARK: - Elements
    
    private var isEditUser = false
    
    var presenter: DetailPresenterProtocol?
    
    var user: Users? {
        didSet {
            userName.text = user?.name
            genderTextField.text = user?.gender
            if let date = user?.date {
                calendarTextField.text = formatDate(date)
            }
        }
    }
    
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
        calendarTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
            if let date = person?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                calendarTextField.text = dateFormatter.string(from: date)
            } else {
                calendarTextField.text = nil
            }
            genderTextField.text = person?.gender
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        setupHirarchy()
        setupLayout()
        presenter?.getUser()
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
            
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 200),
            
            userIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            userIcon.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 30),
            userIcon.widthAnchor.constraint(equalToConstant: 20),
            userIcon.heightAnchor.constraint(equalToConstant: 20),
            
            userName.leadingAnchor.constraint(equalTo: userIcon.trailingAnchor, constant: 8),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userName.centerYAnchor.constraint(equalTo: userIcon.centerYAnchor),
            
            calendarIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            calendarIcon.topAnchor.constraint(equalTo: userIcon.bottomAnchor, constant: 25),
            calendarIcon.widthAnchor.constraint(equalToConstant: 20),
            calendarIcon.heightAnchor.constraint(equalToConstant: 20),
            
            calendarTextField.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 8),
            calendarTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarTextField.centerYAnchor.constraint(equalTo: calendarIcon.centerYAnchor),
            
            genderIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            genderIcon.topAnchor.constraint(equalTo: calendarIcon.bottomAnchor, constant: 25),
            genderIcon.widthAnchor.constraint(equalToConstant: 20),
            genderIcon.heightAnchor.constraint(equalToConstant: 20),
            
            genderTextField.leadingAnchor.constraint(equalTo: genderIcon.trailingAnchor, constant: 8),
            genderTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            genderTextField.centerYAnchor.constraint(equalTo: genderIcon.centerYAnchor),
        ])
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 2 || text.count == 5 {
                textField.text = text + "."
            }
        }
    }
    
    @objc func editUser() {
        if isEditUser {
            userName.isEnabled = false
            calendarTextField.isEnabled = false
            genderTextField.isEnabled = false
            editButton.setTitle("Edit", for: .normal)
            user?.name = userName.text
            user?.gender = genderTextField.text
            user?.date = parseDate(calendarTextField.text)
            updateUserInfo()
        } else {
            userName.isEnabled = true
            calendarTextField.isEnabled = true
            genderTextField.isEnabled = true
            editButton.setTitle("Save", for: .normal)
        }
        isEditUser.toggle()
    }
    
    func updateUserInfo() {
        guard let name = userName.text, !name.isEmpty,
              let gender = genderTextField.text,
              let date = calendarTextField.text
        else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = dateFormatter.date(from: date) {
            presenter?.updateUser(name: name, date: date, gender: gender)
        } else {
            print("Error")
        }
    }
}

