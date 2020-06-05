# SwiftyMoney

Swifty Money is a light-weight library for handling money and currency and their formatting on iOS and macOS.

## Features

SwiftyMoney is inspired by NSMeasurement and its related classes, which are available in Apple's Foundation framework.
SwiftyMoney's features are as follows:
* It provides a Money struct which contains information about a money amount, such as its value and currency. The Money struct represents monetary values by means of Foundation's Decimal struct in order to avoid floating point rounding errors and enable complex mathematical calculations.
* It provides a Currency class which contains information about a monetary unit. 
* It provides a ready-to-use Currencies struct which includes some methods for sorting and filtering currencies together with a set of Currency objects for 150+ currencies used worldwide. These objects include data such as a currency name, code, exponent, country codes of the countries where a particular currency is used.
* It provides a CurrencyConverter class which makes it possible to convert monies to other currencies.
* It provides a simple-to-use string formatter for formatting amounts in different currencies and for different languages.

## How to install

SwiftyMoney is compatible with Swift 4.2 and newer. You can install it:
1. Directly by downloading the repo and dragging its source code files into your project, or
2. Through Carthage by adding the line
```git "git@github.com:krkopec/swiftyMoney.git" "master"``` to your Cartfile and running ```carthage update``` in the Terminal.
3. Through Swift Package Manager by entering the url of the repo: ```https://github.com/krkopec/swiftyMoney/``` and selecting an appropriate branch or version.

Before you start using SwiftyMoney, import it into your source code file by declaring: ```import SwiftyMoney```.

## How to use

As a developer, you will use SwiftyMoney mostly through its main struct called Money. However, before you can create an instance of Money, you must first declare the currency that this instance will be using. Such a way of doing things is by design and it ensures that all necessary parameters of the currency to be used in the Money instance (and by extension the parameters of the Money itself) are properly defined before use.

## Create Currency

In order to create an instance of Currency, you must provide:
1. its name, which may be used for the presentation layer of your application and/or for debugging purposes, 
2. its international ISO code, which may be used for identification of the currency and its interoperatility with third-party currency exchange rate sources,
3. its local symbol, which will be used for formatting money strings, and
4. its exponent property ensures that money amount is provided with a correct number of decimal places, if any. If the exponent property is set to 0, money will be provided, to all intents and purposes, as an integer.

```
let euro = Currency(name: "Euro", 
                    code: "EUR", 
                    symbol: "€", 
                    exponent: 2)
                                    
let swedishKrona = Currency(name: "Swedish krona", 
                            code: "SEK", 
                            symbol: "kr", 
                            exponent: 2)
```

In order to ease the management of different currencies, it is advisable to extend the Currency class by using static properties, as follows:

```
// Extend Currency class
extension Currency {

public static let polishZloty = Currency(name: "Polish zloty",
                                         code: "PLN",
                                         symbol: "zł",
                                         exponent: 2)
}
```
In this way, you will be able to use a currency in a manner similar to an enumeration, as presented below:

```
let defaultCurrency = Currency.polishZloty
```

## Create Money

As mentioned above, in order to create an instance of Money, you must first declare a currency to be used.
Please note that the examples below use currencies declared as static properties of the Currency class, as described above.
You can declare Money, as follows.
``` 
// Create a money amount
let tenEuro = Money(value: 10, currency: .euro)
let twentyKrona = Money(value: 20, currency: .swedishKrona)
```

## Equatability and Comparability

Money conforms to the Equatable and Comparable protocols, so that it is possible to compare its instances.

### Comparing monies of the same currency
```
Money(value: 10, currency: .euro) == Money(value: 10, currency: .euro) // == true
Money(value: 10, currency: .euro) != Money(value: 10, currency: .euro) // == false
Money(value: 10, currency: .euro) < Money(value: 10, currency: .euro)  // == false
```

### Comparing monies of different currencies
You can compare monies provided in different currencies. This, however, requires that you set Money's default currency converter and its baseCurrency, as shown below:
```
Money.setCurrencyConverter(to: CurrencyConverter(baseCurrency: .euro,
                                                 currencyExchangeRates: [euroToUSDollarConversionRate]))
```
Afterwards, you can compare amounts in two different currencies.
```
Money(value: 10, currency: .euro) == Money(value: 10, currency: .usDollar)
Money(value: 10, currency: .euro) != Money(value: 10, currency: .usDollar)
Money(value: 10, currency: .euro) < Money(value: 10, currency: .usDollar)
```

## Arithmetic

Basic arithmetic examples:

  ```
Money(value: 10, currency: .euro) + Money(value: 10, currency: .euro) // == 20 euro
Money(value: 10, currency: .euro) - Money(value: 5, currency: .euro)  // == 5 euro
Money(value: 10, currency: .euro) * 2 // == 20 euro
Money(value: 10, currency: .euro) / 2 // == 5 euro
```

As with comparisons, you can perform mathematical operation on monies of the same or different currencies. 
Depending on the circumstance, the result of addition or subtraction of any money amounts may be returned:
  1. in original currency if both amounts are in the same currency:
  ```
  Money(value: 10, currency: .euro) + Money(value: 10, currency: .euro) // == 20 euro
  ```

  2. in converter's base currency if the amounts are in different currencies and Money's currency converter and corresponding currency exchange rates were set:
  ```
  // Money.currencyConverter.baseCurrency == .euro and eurToUsdConversionRate == 1.12979
  Money(value: 10, currency: .euro) + Money(value: 10, currency: .usDollar) // == 18.85 euro
  ```
  
  3. as nil value if amounts are in different currencies and no currency converter or no corresponding currency exchange rates were set.
  ```
  // Money.currencyConverter.baseCurrency == nil 
  Money(value: 10, currency: .euro) + Money(value: 10, currency: .usDollar) // == nil
  ```
  
## Currency Conversion
  
In order to convert monies to other currencies, you must declare CurrencyConverter first. This may be done through Money's currencyConverter static property or as a separate instance of CurrencyConverter.

CurrencyConverter converts currencies:
1. directly (e.g. from PLN to USD) by using appropriate currency exchange rate pairs contained in its currencyExchangeRates property, or 
2. indirectly (e.g. from PLN to a baseCurrency, e.g. EUR, and then to USD) by using currencyExchangeRates property combined with the optional baseCurrency property, which serves as an intermediate step to simplify the conversion and decrease the number of currency exchange rate combinations needed to convert between multiple currencies.

### Create Currency Converter

In order to create a currency converter, you need specify 
1. its currency exchange rates for direct conversion:
```
// set converter to convert from Euro to US Dollar.
let converter = CurrencyConverter(currencyExchangeRates: [euroToUSDollarRate])
```
2. and additionally its base currency for indirect conversion:
```
// set converter to convert between a number of currencies through common Euro conversion rate.
let converter = CurrencyConverter(baseCurrency: .euro,
                                  currencyExchangeRates: [euroToUSDollarRate, 
                                                          euroToPolishZloty, 
                                                          euroToSwedishKronaRate])
```

### Create Currency Exchange Rate

In order to use currency converter you must first declare currency exchange rates, as follows:

```
let euroToKronaRate = CurrencyExchangeRate(sourceCurrency: .euro,
                                           targetCurrency: .swedishKrona,
                                           allowsInverseConversion: true,
                                           sourceToTargetRate: 10.7405)

// if the allowsInverseConversion property true, then targetToSourceRate == 1 / 10.7405
```

As suggested in the comment above, thanks to the allowsInverseConversion property, CurrencyExchangeRate allows for converting money in one direction (e.g. from EUR to USD) or in two directions (e.g. from EUR to USD and USD to EUR) using one currency exchange rate.


