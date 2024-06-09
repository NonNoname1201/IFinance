class CurrencyExchange {
    var sellRates: [(currency: Currency, rate: Double)] = [
        (.usd, 3.8),
        (.eur, 4.5),
        (.gbp, 5.0),
        (.chf, 3.9),
        (.pln, 1.0)
    ]

    var buyRates: [(currency: Currency, rate: Double)] = [
        (.usd, 3.7),
        (.eur, 4.4),
        (.gbp, 4.9),
        (.chf, 3.8),
        (.pln, 0.9)
    ]

    func convert(from fromCurrency: Currency, to toCurrency: Currency, amount: Double) -> Double? {
        if amount > 0, let fromRate = (buyRates.first { $0.currency == fromCurrency })?.rate,
           let toRate = (sellRates.first { $0.currency == toCurrency })?.rate {
            let plnValue = amount * toRate
            return plnValue / fromRate
        }
        return nil
    }
}
