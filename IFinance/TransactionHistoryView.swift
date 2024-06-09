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
                    TransactionItemView(transaction: transaction)
                        .onDelete { indexSet in
                            deleteTransactions(offsets: indexSet)
                        }
                }
            }
        }
    }
    
    private func addTransaction() {
        guard let amount = Double(transactionAmount), amount >= 0 else {
            // Проверка на корректность суммы транзакции
            // Выводим уведомление, если сумма некорректна
            print("Неправильный формат суммы транзакции")
            return
        }
        
        withAnimation {
            let newTransaction = Transaction(context: viewContext)
            newTransaction.timestamp = Date()
            newTransaction.name = transactionName
            newTransaction.amount = amount
            newTransaction.type = transactionType
            
            do {
                try viewContext.save()
                transactionName = ""
                transactionAmount = ""
                transactionType = "Obciążenie"
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteTransactions(offsets: IndexSet) {
        withAnimation {
            offsets.map { transactions[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct TransactionItemView: View {
    @ObservedObject var transaction: Transaction

    var body: some View {
        VStack(alignment: .leading) {
            Text(transaction.name ?? "Unknown")
                .font(.headline)
            Text(String(format: "%.2f", transaction.amount))
            Text(transaction.type ?? "Unknown")
                .font(.subheadline)
        }
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
