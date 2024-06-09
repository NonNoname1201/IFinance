import SwiftUI

struct LoanCalculationsView: View {
    @State private var principalAmount = ""
    @State private var interestRate = ""
    @State private var loanTerm = ""
    @State private var paymentFrequency = 12 // Assume monthly payments by default

    var body: some View {
        Form {
            Section(header: Text("Principal Amount")) {
                TextField("Enter principal amount", text: $principalAmount)
            }
            Section(header: Text("Interest Rate")) {
                TextField("Enter annual interest rate", text: $interestRate)
            }
            Section(header: Text("Loan Term")) {
                TextField("Enter loan term in years", text: $loanTerm)
            }
            Section(header: Text("Payment Frequency")) {
                Picker("Payment Frequency", selection: $paymentFrequency) {
                    Text("Monthly").tag(12)
                    Text("Quarterly").tag(4)
                    Text("Semi-Annually").tag(2)
                    Text("Annually").tag(1)
                }
            }
            Section {
                Button(action: {
                    // TODO: Implement loan calculation logic
                }) {
                    Text("Calculate")
                }
            }
            // TODO: Display the result
        }
    }
}