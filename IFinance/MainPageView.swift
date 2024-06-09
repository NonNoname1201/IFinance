import SwiftUI

// Main Page
struct MainPageView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CurrencyCalculatorView()) {
                    Text("Currency Calculator")
                }
                NavigationLink(destination: LoanCalculationsView()) {
                    Text("Loan Calculations")
                }
//                NavigationLink(destination: TransactionHistoryView()) {
//                    Text("Transaction History + Data Analysis")
//                }
            }
        }
    }
}
