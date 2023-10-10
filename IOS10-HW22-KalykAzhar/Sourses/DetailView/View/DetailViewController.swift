import UIKit

// MARK: -DetailViewController

class DetailViewController: UIViewController, DetailViewOutput {
    
    // MARK: - Elements
    
    private var isEditUser = false
    
    var presenter: DetailViewInput?
    
    var user: User? {
        didSet {
            userName.text = user?.name
            genderTextField.text = user?.gender
            if let date = user?.date {
                datePicker.date = date
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
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.isEnabled = false
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
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
        view.addSubview(datePicker)
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
            
            datePicker.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -260),
            datePicker.centerYAnchor.constraint(equalTo: calendarIcon.centerYAnchor),
            
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
    
    func updateUserInfo() {
        guard let name = userName.text, !name.isEmpty,
              let gender = genderTextField.text
        else { return }
              let date = datePicker.date
        presenter?.updateUser(name: name, date: date, gender: gender)
    }
    
    @objc func editUser() {
        if isEditUser {
            userName.isEnabled = false
            datePicker.isEnabled = false
            genderTextField.isEnabled = false
            editButton.setTitle("Edit", for: .normal)
            user?.name = userName.text
            user?.gender = genderTextField.text
            user?.date = datePicker.date
        } else {
            userName.isEnabled = true
            datePicker.isEnabled = true
            genderTextField.isEnabled = true
            editButton.setTitle("Save", for: .normal)
        }
        isEditUser.toggle()
    }
}

