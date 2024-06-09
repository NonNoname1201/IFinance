import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newTransaction = Transaction(context: viewContext)
            newTransaction.timestamp = Date()
            newTransaction.name = "Example Transaction"
            newTransaction.amount = 100.0
            newTransaction.type = "Obciążenie"
        }
        do {
            try viewContext.save()
        } catch {
            // Handle the error appropriately in your app
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "YourModelName")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle the error appropriately in your app
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
