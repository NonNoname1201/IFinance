import SwiftUI
import CoreData

struct TransactionHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.timestamp, ascending: true)],
        animation: .default)
    private var transactions: FetchedResults<Transaction>

    @State private var transactionName: String = ""
    @State private var transactionAmount: String = ""
    @State private var transactionType: String = "Obciążenie"
    
    let transactionTypes = ["Obciążenie", "Zaliczenie"]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Dodaj Transakcję")) {
                    TextField("Nazwa Transakcji", text: $transactionName)
                    TextField("Suma Transakcji", text: $transactionAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Typ Transakcji", selection: $transactionType) {
                        ForEach(transactionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    Button(action: addTransaction) {
                        Text("Dodaj Transakcję")
                    }
                }
            }
            
            List {
                ForEach(transactions) { transaction in
                    VStack(alignment: .leading) {
                        Text(transaction.name ?? "Unknown")
                            .font(.headline)
                        Text(String(format: "%.2f", transaction.amount))
                        Text(transaction.type ?? "Unknown")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
    
    private func addTransaction() {
        withAnimation {
            let newTransaction = Transaction(context: viewContext)
            newTransaction.timestamp = Date()
            newTransaction.name = transactionName
            newTransaction.amount = Double(transactionAmount) ?? 0.0
            newTransaction.type = transactionType
            
            do {
                try viewContext.save()
                transactionName = ""
                transactionAmount = ""
                transactionType = "Obciążenie"
            } catch {
                // Handle the error appropriately in your app
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
