import Foundation
import CoreData

class CoreData: CoreDataProtocol {

    static let shared = CoreData()
    var users: [User]?
    
    // MARK: -CoreDataStack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "User")
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
    
    func saveContext () {
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
    
    // MARK: -Actions
    
    func fetchUsers() {
        do {
            users = try context.fetch(User.fetchRequest())
            
        } catch {
            print("Error")
        }
    }
    
    func addNewUser(name: String) {
        let newUser = User(context: context)
        newUser.name = name
        
        do {
            try context.save()
          fetchUsers()
         saveContext()
        } catch {
            print("error save")
        }
    }

    func deleteUser(user: User) {
        context.delete(user)
        
        do {
            try context.save()
            fetchUsers()
            CoreData.shared.saveContext()
        } catch {
            print("Error! Пользователь не удален!")
        }
    }
    
    func updateUser(_ user: User, completion: ((Bool) -> ())) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            completion(true)
            fetchUsers()
            CoreData.shared.saveContext()
        } catch {
            completion(false)
            print("Error! Пользователя не удалось сохранить!")
        }
    }
}
