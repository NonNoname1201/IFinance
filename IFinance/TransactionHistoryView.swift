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
    @State private var errorMessage: String = ""
    
    let transactionTypes = ["Obciążenie", "Zaliczenie"]

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Dodaj Transakcję")) {
                    TextField("Nazwa Transakcji", text: $transactionName)
                    TextField("Suma Transakcji", text: $transactionAmount)
                        .keyboardType(.decimalPad)
                        .onChange(of: transactionAmount) {
                            newValue in
                            if let amount = Double(newValue), amount < 0 {
                                errorMessage = "Nieprawidowy format"
                            } else {
                                errorMessage = ""
                            }
                        }
                    
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
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            List {
                ForEach(transactions) { transaction in
                    TransactionItemView(transaction: transaction)}
                .onDelete { indexSet in
                    deleteTransactions(offsets: indexSet)}
                        }
            }
    }
    
    private func addTransaction() {
        guard let amount = Double(transactionAmount), amount >= 0 else {
            errorMessage = "Nieprawidowy format"
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
