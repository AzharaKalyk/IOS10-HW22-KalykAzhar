import Foundation
import CoreData

final class CoreData {
    
    static let shared = CoreData()
    
    var users: [Users]?
    
    // MARK: -CoreDataStack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HW22")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: -CoreData SavingSupport
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUsers() {
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        
        do {
            users = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    func addNewUser(name: String, gender: String, date: String) {
        let user = Users(context: context)
        user.name = name
        user.gender = gender
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let date = dateFormatter.date(from: date) {
            user.date = date
        } else {
            print("Error parsing date")
        }
        updateUser()
    }
    
    func deleteUser(index: Int) {
        guard let user = users?[index] else { return }
        
        context.delete(user)
        updateUser()
    }
    
    func updateUser() {
        saveContext()
        fetchUsers()
    }
}
