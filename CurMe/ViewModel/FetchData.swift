//
//  FetchData.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 25/06/2021.
//

import SwiftUI

class FetchData: ObservableObject {
    
    @Published var coversionData: [Currency] = []
    @Published var baseCode = "USD"
    @Published var filteredCurrency = "KZT"
    
    init() {
        fetch()
    }
    
    func fetch() {
        
        let url = "https://open.exchangerate-api.com/v6/latest?base=\(baseCode)"
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, _ in
            
            guard let JSONData = data else {return}
            
            do {
                let conversion = try JSONDecoder().decode(Conversion.self, from: JSONData)
                
                DispatchQueue.main.async {
                    self.coversionData = conversion.rates.compactMap({ (key,value) -> Currency? in
                        return Currency(currencyName: key, currencyValue: value)
                    })
                    .filter({ Currency in
                        Currency.currencyName == self.filteredCurrency
                    })
                }
            }
            catch {
                print(error)
            }
        }
        .resume()
    }
    
    func updateData(baseCode: String) {
        
        self.baseCode = baseCode
        
        self.coversionData.removeAll()
        fetch()
        
    }
    
    
}
