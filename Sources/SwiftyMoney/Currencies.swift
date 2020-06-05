//
//  File.swift
//  
//
//  Created by Krystian Kopeć on 03/06/2020.
//

import Foundation

public struct Currencies {

    /// A function that returns an array of Currency objects sorted alphabetically
    public static func currenciesAlphabetically() -> [Currency] {
        return Currencies.currencyList
            .sorted { $0.name.lowercased() < $1.name.lowercased() }
    }

    /// A function that returns an array of currency name strings sorted alphabetically
    public static func currencyNamesAlphabetically() -> [String] {
        return Currencies.currenciesAlphabetically().map { $0.name }
    }

    /// A function that returns an array of arrays of Currency objects, sorted alphabetically
    public static func currencyNamesGroupedAlphabetically() -> [[String]] {

        let currencyNames = Currencies.currencyNamesAlphabetically().removeDuplicates()

        return currencyNames.reduce(into: []) { (result, currencyName) in
            guard let initial = currencyName.first?.uppercased() else { return }

            // create row if a row with such an initial does not exists
            if !result.contains(where: { countriesWithInitial -> Bool in
                countriesWithInitial.first?.first?.uppercased() == initial }) {
                result.append([currencyName])
                // if a row exists, add items to it
            } else {
                guard var lastArray = result.last else { return }
                lastArray.append(currencyName)
                var newCurrencyNamesGrouped = Array(result.dropLast())
                newCurrencyNamesGrouped.append(lastArray)
                result = newCurrencyNamesGrouped
            }
        }
    }

    public static func getCurrency(withCurrencyCode currencyCode : String) -> Currency? {
        return currencyList.first { $0.code == currencyCode }
    }

    public static func getCurrencies(forCountryCode countryCode: String) -> Set<Currency> {
        return currencyList.filter { currency -> Bool in
            currency.countryCodes.contains(countryCode)
        }
    }

    private static let currencyList: Set<Currency> = Set([

        Currency(name: "Afghan Afghani", code: "AFN", symbol: nil,
                 exponent: 2, fractionalUnitName: "Pul", countryCodes: ["AF"]),
        Currency(name: "Albanian Lek", code: "ALL", symbol: "L",
                 exponent: 2, fractionalUnitName: "Qindarkë", countryCodes: ["AL"]),
        Currency(name: "Algerian Dinar", code: "DZD", symbol: nil,
                 exponent: 2, fractionalUnitName: "Santeem", countryCodes: ["DZ"]),
        Currency(name: "Angolan Kwanza", code: "AOA", symbol: "Kz",
                 exponent: 2, fractionalUnitName: "Cêntimo", countryCodes: ["AO"]),
        Currency(name: "Argentine Peso", code: "ARS", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["AR"]),
        Currency(name: "Armenian Dram", code: "AMD", symbol: "֏",
                 exponent: 2, fractionalUnitName: "Luma", countryCodes: ["AM"]),
        Currency(name: "Aruban Florin", code: "AWG", symbol: "ƒ",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["AW"]),
        Currency(name: "Australian Dollar", code: "AUD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent",
                 countryCodes: ["AU", "KI", "NR", "TV"]),
        Currency(name: "Azerbaijani Manat", code: "AZN", symbol: "₼",
                 exponent: 2, fractionalUnitName: "Qəpik", countryCodes: ["AZ"]),
        Currency(name: "Bahamian Dollar", code: "BSD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["BS"]),
        Currency(name: "Bahraini Dinar", code: "BHD", symbol: nil,
                 exponent: 3, fractionalUnitName: "Fils", countryCodes: ["BH"]),
        Currency(name: "Bangladeshi Taka", code: "BDT", symbol: "৳",
                 exponent: 2, fractionalUnitName: "Poisha", countryCodes: ["BD"]),
        Currency(name: "Barbadian Dollar", code: "BBD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["BB"]),
        Currency(name: "Belarusian Ruble", code: "BYN", symbol: "Br",
                 exponent: 2, fractionalUnitName: "Kapyeyka", countryCodes: ["BY"]),
        Currency(name: "Belize Dollar", code: "BZD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["BZ"]),
        Currency(name: "Bermudian Dollar", code: "BMD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["BM"]),
        Currency(name: "Bhutanese Ngultrum", code: "BTN", symbol: "Nu.",
                 exponent: 2, fractionalUnitName: "Chetrum", countryCodes: ["BT"]),
        Currency(name: "Bolivian Boliviano", code: "BOB", symbol: "Bs.",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["BO"]),
        Currency(name: "Bosnia and Herzegovina Convertible Mark", code: "BAM", symbol: "KM",
                 exponent: 2, fractionalUnitName: "Fening", countryCodes: ["BA"]),
        Currency(name: "Botswana Pula", code: "BWP", symbol: "P",
                 exponent: 2, fractionalUnitName: "Thebe", countryCodes: ["BW"]),
        Currency(name: "Brazilian Real", code: "BRL", symbol: "R$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["BR"]),
        Currency(name: "British Pound Sterling", code: "GBP", symbol: "£",
                 exponent: 2, fractionalUnitName: "Penny", countryCodes: ["UK"]),
        Currency(name: "Brunei Dollar", code: "BND", symbol: "$",
                 exponent: 2, fractionalUnitName: "Sen", countryCodes: ["BN", "SG"]),
        Currency(name: "Bulgarian Lev", code: "BGN", symbol: "лв.",
                 exponent: 2, fractionalUnitName: "Stotinka", countryCodes: ["BG"]),
        Currency(name: "Burmese Kyat", code: "MMK", symbol: "Ks",
                 exponent: 2, fractionalUnitName: "Pya", countryCodes: ["MM"]),
        Currency(name: "Burundian Franc", code: "BIF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["BI"]),
        Currency(name: "Cambodian Riel", code: "KHR", symbol: "៛",
                 exponent: 2, fractionalUnitName: "Sen", countryCodes: ["KH"]),
        Currency(name: "Canadian Dollar", code: "CAD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["CA"]),
        Currency(name: "Cape Verdean Escudo", code: "CVE", symbol: "Esc",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["CV"]),
        Currency(name: "Cayman Islands Dollar", code: "KYD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["KY"]),
        Currency(name: "Central African Cfa Franc", code: "XAF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime",
                 countryCodes: ["CM", "CF", "TD", "CG", "GQ", "GA"]),
        Currency(name: "Cfp Franc", code: "XPF", symbol: "₣",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["PF", "NC"]),
        Currency(name: "Chilean Peso", code: "CLP", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["CL"]),
        Currency(name: "Chinese Yuan", code: "CNY", symbol: "¥",
                 exponent: 1, fractionalUnitName: "Jiao", countryCodes: ["CN"]),
        Currency(name: "Colombian Peso", code: "COP", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["CO"]),
        Currency(name: "Comorian Franc", code: "KMF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["KM"]),
        Currency(name: "Congolese Franc", code: "CDF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["CD"]),
        Currency(name: "Cook Islands Dollar", code: "CKD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["CK"]),
        Currency(name: "Costa Rican Colón", code: "CRC", symbol: "₡",
                 exponent: 2, fractionalUnitName: "Céntimo", countryCodes: ["CR"]),
        Currency(name: "Croatian Kuna", code: "HRK", symbol: "kn",
                 exponent: 2, fractionalUnitName: "Lipa", countryCodes: ["HR"]),
        Currency(name: "Cuban Convertible Peso", code: "CUC", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["CU"]),
        Currency(name: "Cuban Peso", code: "CUP", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["CU"]),
        Currency(name: "Czech Koruna", code: "CZK", symbol: "Kč",
                 exponent: 2, fractionalUnitName: "Haléř", countryCodes: ["CZ"]),
        Currency(name: "Danish Krone", code: "DKK", symbol: "kr",
                 exponent: 2, fractionalUnitName: "Øre",
                 countryCodes: ["DK", "FO"]),
        Currency(name: "Djiboutian Franc", code: "DJF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["DJ"]),
        Currency(name: "Dominican Peso", code: "DOP", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["DO"]),
        Currency(name: "Eastern Caribbean Dollar", code: "XCD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent",
                 countryCodes: ["AI", "AG", "DM", "GD", "MS", "KN", "LC", "VC"]),
        Currency(name: "Egyptian Pound", code: "EGP", symbol: nil,
                 exponent: 2, fractionalUnitName: "Piastre", countryCodes: ["EG"]),
        Currency(name: "Eritrean Nakfa", code: "ERN", symbol: "Nfk",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["ER"]),
        Currency(name: "Ethiopian Birr", code: "ETB", symbol: "Br",
                 exponent: 2, fractionalUnitName: "Santim", countryCodes: ["ET"]),
        Currency(name: "Euro", code: "EUR", symbol: "€",
                 exponent: 2, fractionalUnitName: "Cent",
                 countryCodes: ["AD", "AT", "BE", "CY", "EE", "FI", "FR", "DE", "GR",
                            "IE", "IT", "KV", "LV", "LT", "LU", "MT", "MC", "ME",
                            "NL", "PT", "SM", "SK", "SI", "ES", "VA"]),
        Currency(name: "Falkland Islands Pound", code: "FKP", symbol: "£",
                 exponent: 2, fractionalUnitName: "Penny", countryCodes: ["FK"]),
        Currency(name: "Faroese Króna", code: "FOK", symbol: "kr",
                 exponent: 2, fractionalUnitName: "Oyra", countryCodes: ["FO"]),
        Currency(name: "Fijian Dollar", code: "FJD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["FJ"]),
        Currency(name: "Gambian Dalasi", code: "GMD", symbol: "D",
                 exponent: 2, fractionalUnitName: "Butut", countryCodes: ["GM"]),
        Currency(name: "Georgian Lari", code: "GEL", symbol: "₾",
                 exponent: 2, fractionalUnitName: "Tetri", countryCodes: ["GE"]),
        Currency(name: "Ghanaian Cedi", code: "GHS", symbol: "₵",
                 exponent: 2, fractionalUnitName: "Pesewa", countryCodes: ["GH"]),
        Currency(name: "Gibraltar Pound", code: "GIP", symbol: "£",
                 exponent: 2, fractionalUnitName: "Penny", countryCodes: ["GI"]),
        Currency(name: "Guatemalan Quetzal", code: "GTQ", symbol: "Q",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["GT"]),
        Currency(name: "Guinean Franc", code: "GNF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["GN"]),
        Currency(name: "Guyanese Dollar", code: "GYD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["GY"]),
        Currency(name: "Haitian Gourde", code: "HTG", symbol: "G",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["HT"]),
        Currency(name: "Honduran Lempira", code: "HNL", symbol: "L",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["HN"]),
        Currency(name: "Hong Kong Dollar", code: "HKD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["HK"]),
        Currency(name: "Hungarian Forint", code: "HUF", symbol: "Ft",
                 exponent: 2, fractionalUnitName: "Fillér", countryCodes: ["HU"]),
        Currency(name: "Icelandic Króna", code: "ISK", symbol: "kr",
                 exponent: 2, fractionalUnitName: "Eyrir", countryCodes: ["IS"]),
        Currency(name: "Indian Rupee", code: "INR", symbol: "₹",
                 exponent: 2, fractionalUnitName: "Paisa", countryCodes: ["BT", "IN"]),
        Currency(name: "Indonesian Rupiah", code: "IDR", symbol: "Rp",
                 exponent: 2, fractionalUnitName: "Sen", countryCodes: ["ID"]),
        Currency(name: "Iranian Rial", code: "IRR", symbol: nil,
                 exponent: 2, fractionalUnitName: "Geran", countryCodes: ["IR"]),
        Currency(name: "Iraqi Dinar", code: "IQD", symbol: nil,
                 exponent: 3, fractionalUnitName: "Fils", countryCodes: ["IQ"]),
        Currency(name: "Israeli New Shekel", code: "ILS", symbol: "₪",
                 exponent: 2, fractionalUnitName: "Agora", countryCodes: ["IL"]),
        Currency(name: "Jamaican Dollar", code: "JMD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["JM"]),
        Currency(name: "Japanese Yen", code: "JPY", symbol: "¥",
                 exponent: 2, fractionalUnitName: "Sen", countryCodes: ["JP"]),
        Currency(name: "Jordanian Dinar", code: "JOD", symbol: nil,
                 exponent: 2, fractionalUnitName: "Piastre", countryCodes: ["JO"]),
        Currency(name: "Kazakhstani Tenge", code: "KZT", symbol: "₸",
                 exponent: 2, fractionalUnitName: "Tıyn", countryCodes: ["KZ"]),
        Currency(name: "Kenyan Shilling", code: "KES", symbol: "Sh",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["KE"]),
        Currency(name: "Kiribati Dollar", code: "KID", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["KI"]),
        Currency(name: "Kuwaiti Dinar", code: "KWD", symbol: nil,
                 exponent: 3, fractionalUnitName: "Fils", countryCodes: ["KW"]),
        Currency(name: "Kyrgyzstani Som", code: "KGS", symbol: "с",
                 exponent: 2, fractionalUnitName: "Tyiyn", countryCodes: ["KG"]),
        Currency(name: "Lao Kip", code: "LAK", symbol: "₭",
                 exponent: 2, fractionalUnitName: "Att", countryCodes: ["LA"]),
        Currency(name: "Lebanese Pound", code: "LBP", symbol: nil,
                 exponent: 2, fractionalUnitName: "Piastre", countryCodes: ["LB"]),
        Currency(name: "Lesotho Loti", code: "LSL", symbol: "L",
                 exponent: 2, fractionalUnitName: "Sente", countryCodes: ["LS"]),
        Currency(name: "Liberian Dollar", code: "LRD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["LR"]),
        Currency(name: "Libyan Dinar", code: "LYD", symbol: nil,
                 exponent: 3, fractionalUnitName: "Dirham", countryCodes: ["LY"]),
        Currency(name: "Macanese Pataca", code: "MOP", symbol: "P",
                 exponent: 2, fractionalUnitName: "Avo", countryCodes: ["MO"]),
        Currency(name: "Macedonian Denar", code: "MKD", symbol: "ден",
                 exponent: 2, fractionalUnitName: "Deni", countryCodes: ["MK"]),
        Currency(name: "Malawian Kwacha", code: "MWK", symbol: "MK",
                 exponent: 2, fractionalUnitName: "Tambala", countryCodes: ["MW"]),
        Currency(name: "Malaysian Ringgit", code: "MYR", symbol: "RM",
                 exponent: 2, fractionalUnitName: "Sen", countryCodes: ["MY"]),
        Currency(name: "Maldivian Rufiyaa", code: "MVR", symbol: nil,
                 exponent: 2, fractionalUnitName: "Laari", countryCodes: ["MV"]),
        Currency(name: "Manx Pound", code: "IMP", symbol: "£",
                 exponent: 2, fractionalUnitName: "Penny", countryCodes: ["IM"]),
        Currency(name: "Mauritian Rupee", code: "MUR", symbol: "₨",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["MU"]),
        Currency(name: "Mexican Peso", code: "MXN", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["MX"]),
        Currency(name: "Moldovan Leu", code: "MDL", symbol: "L",
                 exponent: 2, fractionalUnitName: "Ban", countryCodes: ["MD"]),
        Currency(name: "Mongolian Tögrög", code: "MNT", symbol: "₮",
                 exponent: 2, fractionalUnitName: "Möngö", countryCodes: ["MN"]),
        Currency(name: "Moroccan Dirham", code: "MAD", symbol: nil,
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["MA"]),
        Currency(name: "Mozambican Metical", code: "MZN", symbol: "MT",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["MZ"]),
        Currency(name: "Namibian Dollar", code: "NAD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["NA"]),
        Currency(name: "Nepalese Rupee", code: "NPR", symbol: nil,
                 exponent: 2, fractionalUnitName: "Paisa", countryCodes: ["NP"]),
        Currency(name: "New Taiwan Dollar", code: "TWD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["TW"]),
        Currency(name: "New Zealand Dollar", code: "NZD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["CK", "NZ"]),
        Currency(name: "Nicaraguan Córdoba", code: "NIO", symbol: "C$",
                 exponent: 2, fractionalUnitName: "Centavo", countryCodes: ["NI"]),
        Currency(name: "Nigerian Naira", code: "NGN", symbol: "₦",
                 exponent: 2, fractionalUnitName: "Kobo", countryCodes: ["NG"]),
        Currency(name: "North Korean Won", code: "KPW", symbol: "₩",
                 exponent: 2, fractionalUnitName: "Chon", countryCodes: ["KP"]),
        Currency(name: "Norwegian Krone", code: "NOK", symbol: "kr",
                 exponent: 2, fractionalUnitName: "Øre", countryCodes: ["NO"]),
        Currency(name: "Omani Rial", code: "OMR", symbol: nil,
                 exponent: 3, fractionalUnitName: "Baisa", countryCodes: ["OM"]),
        Currency(name: "Pakistani Rupee", code: "PKR", symbol: "₨",
                 exponent: 2, fractionalUnitName: "Paisa", countryCodes: ["PK"]),
        Currency(name: "Panamanian Balboa", code: "PAB", symbol: "B/.",
                 exponent: 2, fractionalUnitName: "Centésimo", countryCodes: ["PA"]),
        Currency(name: "Papua New Guinean Kina", code: "PGK", symbol: "K",
                 exponent: 2, fractionalUnitName: "Toea", countryCodes: ["PG"]),
        Currency(name: "Paraguayan Guaraní", code: "PYG", symbol: "₲",
                 exponent: 2, fractionalUnitName: "Céntimo", countryCodes: ["PY"]),
        Currency(name: "Peruvian Sol", code: "PEN", symbol: "S/.",
                 exponent: 2, fractionalUnitName: "Céntimo", countryCodes: ["PE"]),
        Currency(name: "Philippine Peso", code: "PHP", symbol: "₱",
                 exponent: 2, fractionalUnitName: "Sentimo", countryCodes: ["PH"]),
        Currency(name: "Polish Złoty", code: "PLN", symbol: "zł",
                 exponent: 2, fractionalUnitName: "Grosz", countryCodes: ["PL"]),
        Currency(name: "Qatari Riyal", code: "QAR", symbol: nil,
                 exponent: 2, fractionalUnitName: "Dirham", countryCodes: ["QA"]),
        Currency(name: "Romanian Leu", code: "RON", symbol: "lei",
                 exponent: 2, fractionalUnitName: "Ban", countryCodes: ["RO"]),
        Currency(name: "Russian Ruble", code: "RUB", symbol: "₽",
                 exponent: 2, fractionalUnitName: "Kopek", countryCodes: ["RU", "UA"]),
        Currency(name: "Rwandan Franc", code: "RWF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime", countryCodes: ["RW"]),
        Currency(name: "Saint Helena Pound", code: "SHP", symbol: "£",
                 exponent: 2, fractionalUnitName: "Penny", countryCodes: ["SH"]),
        Currency(name: "Samoan Tālā", code: "WST", symbol: "T",
                 exponent: 2, fractionalUnitName: "Sene", countryCodes: ["WS"]),
        Currency(name: "São Tomé and Príncipe Dobra", code: "STN", symbol: "Db",
                 exponent: 2, fractionalUnitName: "Cêntimo", countryCodes: ["ST"]),
        Currency(name: "Saudi Riyal", code: "SAR", symbol: nil,
                 exponent: 2, fractionalUnitName: "Halala", countryCodes: ["SA"]),
        Currency(name: "Serbian Dinar", code: "RSD", symbol: "дин.",
                 exponent: 2, fractionalUnitName: "Para", countryCodes: ["RS"]),
        Currency(name: "Seychellois Rupee", code: "SCR", symbol: "₨",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["SC"]),
        Currency(name: "Sierra Leonean Leone", code: "SLL", symbol: "Le",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["SL"]),
        Currency(name: "Singapore Dollar", code: "SGD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["BN", "SG"]),
        Currency(name: "Solomon Islands Dollar", code: "SBD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["SB"]),
        Currency(name: "Somali Shilling", code: "SOS", symbol: "Sh",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["SO"]),
        Currency(name: "South African Rand", code: "ZAR", symbol: "R",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["LS", "NA", "ZA"]),
        Currency(name: "South Korean Won", code: "KRW", symbol: "₩",
                 exponent: 2, fractionalUnitName: "Jeon", countryCodes: ["KR"]),
        Currency(name: "Sri Lankan Rupee", code: "LKR", symbol: "Rs",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["LK"]),
        Currency(name: "Sudanese Pound", code: "SDG", symbol: nil,
                 exponent: 2, fractionalUnitName: "Piastre", countryCodes: ["SD"]),
        Currency(name: "Surinamese Dollar", code: "SRD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["SR"]),
        Currency(name: "Swedish Krona", code: "SEK", symbol: "kr",
                 exponent: 2, fractionalUnitName: "Öre", countryCodes: ["SE"]),
        Currency(name: "Swiss Franc", code: "CHF", symbol: "Fr.",
                 exponent: 2, fractionalUnitName: "Rappen", countryCodes: ["LI", "CH"]),
        Currency(name: "Syrian Pound", code: "SYP", symbol: "£",
                 exponent: 2, fractionalUnitName: "Piastre", countryCodes: ["SY"]),
        Currency(name: "Tajikistani Somoni", code: "TJS", symbol: "ЅМ",
                 exponent: 2, fractionalUnitName: "Diram", countryCodes: ["TJ"]),
        Currency(name: "Tanzanian Shilling", code: "TZS", symbol: "Sh",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["TZ"]),
        Currency(name: "Thai Baht", code: "THB", symbol: "฿",
                 exponent: 2, fractionalUnitName: "Satang", countryCodes: ["TH"]),
        Currency(name: "Tongan Paʻanga", code: "TOP", symbol: "T$",
                 exponent: 2, fractionalUnitName: "Seniti", countryCodes: ["TO"]),
        Currency(name: "Trinidad and Tobago Dollar", code: "TTD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["TT"]),
        Currency(name: "Tunisian Dinar", code: "TND", symbol: nil,
                 exponent: 3, fractionalUnitName: "Millime", countryCodes: ["TN"]),
        Currency(name: "Turkish Lira", code: "TRY", symbol: "₺",
                 exponent: 2, fractionalUnitName: "Kuruş", countryCodes: ["TR"]),
        Currency(name: "Turkmenistan Manat", code: "TMT", symbol: "m",
                 exponent: 2, fractionalUnitName: "Tennesi", countryCodes: ["TM"]),
        Currency(name: "Tuvaluan Dollar", code: "TVD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["TV"]),
        Currency(name: "Ugandan Shilling", code: "UGX", symbol: "Sh",
                 exponent: 2, fractionalUnitName: "Cent", countryCodes: ["UG"]),
        Currency(name: "Ukrainian Hryvnia", code: "UAH", symbol: "₴",
                 exponent: 2, fractionalUnitName: "Kopiyka", countryCodes: ["UA"]),
        Currency(name: "United Arab Emirates Dirham", code: "AED", symbol: nil,
                 exponent: 2, fractionalUnitName: "Fils", countryCodes: ["AE"]),
        Currency(name: "United States Dollar", code: "USD", symbol: "$",
                 exponent: 2, fractionalUnitName: "Cent",
                 countryCodes: ["VG", "EC", "SV", "MH", "FM", "PW", "PA", "TC", "US"]),
        Currency(name: "Uruguayan Peso", code: "UYU", symbol: "$",
                 exponent: 2, fractionalUnitName: "Centésimo", countryCodes: ["UY"]),
        Currency(name: "Uzbekistani Soʻm", code: "UZS", symbol: "so'm",
                 exponent: 2, fractionalUnitName: "Tiyin", countryCodes: ["UZ"]),
        Currency(name: "Venezuelan Bolívar Soberano", code: "VES", symbol: "Bs.S.",
                 exponent: 2, fractionalUnitName: "Céntimo", countryCodes: ["VE"]),
        Currency(name: "Vietnamese Đồng", code: "VND", symbol: "₫",
                 exponent: 1, fractionalUnitName: "Hào", countryCodes: ["VN"]),
        Currency(name: "West African Cfa Franc", code: "XOF", symbol: "Fr",
                 exponent: 2, fractionalUnitName: "Centime",
                 countryCodes: ["BJ", "BF", "CI", "GW", "ML", "NE", "SN", "TG"]),
        Currency(name: "Yemeni Rial", code: "YER", symbol: nil,
                 exponent: 2, fractionalUnitName: "Fils", countryCodes: ["YE"]),
        Currency(name: "Zambian Kwacha", code: "ZMW", symbol: "ZK",
                 exponent: 2, fractionalUnitName: "Ngwee", countryCodes: ["ZM"])
    ])
}
