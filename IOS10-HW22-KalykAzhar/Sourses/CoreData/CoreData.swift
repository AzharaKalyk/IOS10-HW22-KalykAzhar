import Foundation
import CoreData

final class CoreData: CoreDataProtocol {
    var models: [Users]?
    
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
    
    // MARK: -Actions
    
    func fetchUsers() {
        do {
            models = try context.fetch(Users.fetchRequest())
            
        } catch {
            print("Error")
        }
    }
    
    func addNewUser(name: String) {
        let user = Users(context: context)
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
    
    func updateName(item: Users, newName: String) {
        item.name = newName
        
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
    
    func updateGender(item: Users, newGender: String) {
        item.gender = newGender
        
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
    
    func updateDate(item: Users, newDate: Date) {
        item.date = newDate
        
        do {
            try context.save()
            fetchUsers()
        } catch {
            print("Error")
        }
    }
}
