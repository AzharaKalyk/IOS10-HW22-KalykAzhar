import Foundation
import CoreData

final class CoreData: CoreDataProtocol {
    var models: [User]?
    
    static let shared = CoreData()
    
    var users: [User]?
    
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
    
    // MARK: -Actions
    
    func fetchUsers() {
        do {
            models = try context.fetch(User.fetchRequest())
            
        } catch {
            print("Error")
        }
    }
    
    func addNewUser(name: String) {
        let user = User(context: context)
        user.name = name
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
    
    func deleteUser(index: Int) {
        guard let user = models?[index] else { return }
        
        context.delete(user)
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
    
    func updateName(item: User, newName: String) {
        item.name = newName
        
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
    
    func updateGender(item: User, newGender: String) {
        item.gender = newGender
        
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
    
    func updateDate(item: User, newDate: Date) {
        item.date = newDate
        
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
}
