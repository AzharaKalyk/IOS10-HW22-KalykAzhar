import Foundation

protocol DetailViewOutput: AnyObject {
    var user: User? { get set }
    func updateName()
    func updateGender()
    func updateDate()
}

protocol DetailViewInput {
    init(view: DetailViewOutput, dataManager: CoreDataProtocol, user: User)
    func updateName(item: User, newName: String)
    func updateGender(item: User, newGender: String)
    func updateDate(item: User, newDate: Date)
}
