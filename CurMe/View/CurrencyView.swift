//
//  CurrencyView.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 27/06/2021.
//

//




import SwiftUI

struct CurrencyView: View {
    
    @StateObject var viewModel = FetchData()
    
    
    enum currencyChoice {
        case Kazakhstan, Rubles, Usa
        
        func image() -> Image {
            switch self {
            
            case .Kazakhstan:  return Image("kz")
                
            case .Rubles:      return Image("rub")
                
            case .Usa:         return Image("usa")
                
            }
        }
        
        func operation(_ input: Double) -> Double {
            switch self {
            case .Kazakhstan: return (input * 425)
            case .Rubles: return (input * 5)
            case .Usa: return (input * 5)
            
            }
        }
        
    }
    
    var function : currencyChoice
    @Binding var state : CalculationState
    
    var body: some View {
        
        
        
        return function.image()
//        return Text(function.string())
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
            .cornerRadius(40)
            .onTapGesture {
                state.currentNumber = function.operation(state.currentNumber)
            }
        
    }
}
