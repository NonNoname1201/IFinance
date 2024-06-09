import SwiftUI

struct LoanCalculationsView: View {
    @State private var principalAmount = ""
    @State private var interestRate = ""
    @State private var loanTerm = ""
    @State private var paymentFrequency = 12 // Assume monthly payments by default
    @State private var result = "" // New state property for the result
    @State private var errorMessage = "" // New state property for the error message

    var body: some View {
        Form {
            Section(header: Text("Principal Amount")) {
                TextField("Enter principal amount", text: $principalAmount)
                    .onChange(of: principalAmount) { newValue in
                        if let value = Double(newValue), value >= 0 {
                            errorMessage = ""
                        } else {
                            errorMessage = "Please enter a non-negative number for the principal amount."
                        }
                    }
            }
            Section(header: Text("Interest Rate")) {
                TextField("Enter annual interest rate", text: $interestRate)
                    .onChange(of: interestRate) { newValue in
                        if let value = Double(newValue), value >= 0 {
                            errorMessage = ""
                        } else {
                            errorMessage = "Please enter a non-negative number for the interest rate."
                        }
                    }
            }
            Section(header: Text("Loan Term")) {
                TextField("Enter loan term in years", text: $loanTerm)
                    .onChange(of: loanTerm) { newValue in
                        if let value = Double(newValue), value >= 0 {
                            errorMessage = ""
                        } else {
                            errorMessage = "Please enter a non-negative number for the loan term."
                        }
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

            if !errorMessage.isEmpty {
                Section {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            
        }
    }
}