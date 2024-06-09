import SwiftUI

struct LoanCalculationsView: View {
    @State private var principalAmount = ""
    @State private var interestRate = ""
    @State private var loanTerm = ""
    @State private var paymentFrequency = 12
    @State private var result = 0.0
    @State private var errorMessage1 = ""
    @State private var errorMessage2 = ""
    @State private var errorMessage3 = ""
    @State private var errorMessage4 = ""
@State private var activeErrorMessage = ""

    var body: some View {
        Form {
            Section(header: Text("Principal Amount")) {
                TextField("Enter principal amount", text: $principalAmount)
                    .onChange(of: principalAmount) { newValue in
                        if let value = Double(newValue), value >= 0 {
                            errorMessage1 = ""
                        } else {
                            errorMessage1 = "Please enter a non-negative number for the principal amount."
                        }
                    }
            }
            Section(header: Text("Interest Rate")) {
                TextField("Enter annual interest rate", text: $interestRate)
                    .onChange(of: interestRate) { newValue in
                        if let value = Double(newValue), value >= 0 {
                            errorMessage2 = ""
                        } else {
                            errorMessage2 = "Please enter a non-negative number for the interest rate."
                        }
                    }
            }
            Section(header: Text("Loan Term")) {
                TextField("Enter loan term in years", text: $loanTerm)
                    .onChange(of: loanTerm) { newValue in
                        if let value = Double(newValue), value >= 0 {
                            errorMessage3 = ""
                        } else {
                            errorMessage3 = "Please enter a non-negative number for the loan term."
                        }
                    }
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

                    let res = numerator / denominator
                    if res.isNaN || res.isInfinite || errorMessage1 != "" || errorMessage2 != "" || errorMessage3 != ""{
                        result = 0.0
                        errorMessage4 = "Invalid input. Please check your values."
                    } else {
                        result = res
                        errorMessage4 = ""
                    }
                }) {
                    Text("Calculate")
                }
                
            }

            Section(header: Text("\(paymentFrequency == 12 ? "Monthly" : paymentFrequency == 4 ? "Quarterly" : paymentFrequency == 2 ? "Semi-Annually" : "Annually") Payment")) {
                    let resultString = String(format: "%.2f", result)
                    Text("$\(resultString)")
                }

            

            if !errorMessage1.isEmpty {
    activeErrorMessage = errorMessage1
}
if !errorMessage2.isEmpty {
    activeErrorMessage = errorMessage2
}
if !errorMessage3.isEmpty {
    activeErrorMessage = errorMessage3
}
if !errorMessage4.isEmpty {
    activeErrorMessage = errorMessage4
}

if !activeErrorMessage.isEmpty {
    Section {
        Text(activeErrorMessage)
            .foregroundColor(.red)
    }
}
            
        }
    }
}
