//
//  Currency.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 25/06/2021.
//

import SwiftUI

struct Currency: Identifiable {
    
    var id = UUID().uuidString
    var currencyName : String
    var currencyValue: Double
    
}

//var selectedCurrencie = ["USD", "AED", "KZT", "RUB"]

var currencies = ["USD", "AED", "KZT", "RUB"]

//var kazCurrency = ["KZT"]
