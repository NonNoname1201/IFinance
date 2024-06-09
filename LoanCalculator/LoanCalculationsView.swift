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
                    let principal = Double(principalAmount) ?? 0
                    let annualInterestRate = Double(interestRate) ?? 0
                    let termInYears = Double(loanTerm) ?? 0

                    let monthlyInterestRate = annualInterestRate / 100 / Double(paymentFrequency)
                    let numberOfPayments = termInYears * Double(paymentFrequency)

                    let numerator = monthlyInterestRate * principal
                    let denominator = 1 - pow(1 + monthlyInterestRate, -numberOfPayments)

                    let monthlyPayment = numerator / denominator
                }) {
                    Text("Calculate")
                }
            }

            Section(header: Text("\(paymentFrequency == 12 ? "Monthly" : paymentFrequency == 4 ? "Quarterly" : paymentFrequency == 2 ? "Semi-Annually" : "Annually") Payment")) {
                Text("$\(result)")
            }
            
        }
    }
}