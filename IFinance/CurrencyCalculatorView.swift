import SwiftUI

struct CurrencyCalculatorView: View {
    @State private var selectedFromCurrency = Currency.usd
    @State private var selectedToCurrency = Currency.eur
    @State private var inputValue = ""
    @State private var resultText = ""
    @State private var errorMessage = ""
    
    private var currencyExchange = CurrencyExchange()
    
    var body: some View {
        VStack{
            HStack{
                Section(header: Text("Buying:")) {
                    Picker("Select Currency", selection: $selectedToCurrency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.rawValue).tag(currency)
                        }
                    }
                }
                Section(header: Text("Paying in:")) {
                    Picker("Select Currency", selection: $selectedFromCurrency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.rawValue).tag(currency)
                        }
                    }
                }
            }.padding()
            Section{
                TextField("Enter amount", text: $inputValue)
                    .keyboardType(.decimalPad)
            }.padding()
            
            Section {
                
            Button(action: {
                if let inputValue = Double(inputValue),
                   let result = currencyExchange.convert(from: selectedFromCurrency, to: selectedToCurrency, amount: inputValue) {
                    let resultString = String(format: "%.2f", result)
                    self.resultText = "\(resultString) \(selectedFromCurrency.rawValue) is \(inputValue) \(selectedToCurrency.rawValue)"
                    errorMessage = ""
                } else {
                    self.resultText = "\(0) \(selectedFromCurrency.rawValue) is \(0) \(selectedToCurrency.rawValue)"
                    errorMessage = "Please enter a valid data."
                }
            })
            {
                Text("Calculate").font(.title2)
            }.padding()
                Text(resultText).font(.title)
                    .onTapGesture {
                        swap(&selectedFromCurrency, &selectedToCurrency)
                    }
                if !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
            }
        }.padding()
    }
}
