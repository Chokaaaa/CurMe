//
//  FetchData.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 25/06/2021.
//

import SwiftUI

class FetchData: ObservableObject {
    
    //@Published var coversionData: [Currency] = []
    @Published var baseCode = "USD"
    //@Published var filteredCurrency = "KZT"
    static var conversionData: Conversion? = nil

    
    
    //"https://api-test.bcc.kz/bcc/production/v1/public/rates"
    
    func fetch(function: String = #function) {
        print("function:\(function)")
        let url = "https://open.exchangerate-api.com/v6/latest?base=\(baseCode)"
        print("url:\(url)")
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, error in
            
            guard let JSONData = data else {return}
            
            do {
                let conversion = try JSONDecoder().decode(Conversion.self, from: JSONData)
                FetchData.conversionData = conversion
            }
            catch {
                print(error)
            }
        }
        .resume()
    }
    
    func updateData(baseCode: String) {
        
        self.baseCode = baseCode
        
        FetchData.conversionData = nil
        fetch()
        
    }
    
    
}
