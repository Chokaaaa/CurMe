//
//  ActionView.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 28/06/2021.
//

import SwiftUI

struct ActionView: View {
    
    //MARK: - Properties
    enum Action {
        case equal, clear, plus, minus, multiply, divide, percent
        
        func image() -> Image {
            switch self {
            case .equal: return Image(systemName: "equal")
            case .clear: return Image("AC")
            case .plus: return Image(systemName: "plus")
            case .minus: return Image(systemName: "minus")
            case .multiply: return Image(systemName: "multiply")
            case .divide: return Image(systemName: "divide")
            case .percent: return Image(systemName: "percent")
            }
        }
        
        
        func calculate(_ input1: Double, _ input2: Double) -> Double? {
            
            switch self {
            
            case.plus: return input1 + input2
            case.minus: return input1 - input2
            case.multiply: return input1 * input2
            case.divide: return input1 / input2
            
            
            default: return nil
            }
            
        }
        
    }
    
    
    let action: Action
//    let cur: CurrencyView
    @Binding var state : CalculationState
//    @Binding var cur : CurrencyView
    
    //MARK: - Body
    
    var body: some View {
        action.image()
            .font(.title.weight(.bold))
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .background(Color(#colorLiteral(red: 0.7915069461, green: 0.2042710781, blue: 0.005942102056, alpha: 1)))
            .cornerRadius(40)
            .onTapGesture {
                self.tapped()
            }
        
    }
    
        func tapped() {
        switch action {
        case .clear:
            
            //Clear button is pressed.
            state.currentNumber = 0
            state.storedNumber = nil
            state.storedAction = nil
//            state.currencyLight = false
//            state.circleBorder = false
//            state.tappedAgain = false
            
            

            break
            
            //Equal Button is pressed
        case .equal:
            guard let storedAction = state.storedAction else {
                
                return
            }
            
            guard let storedNumber = state.storedNumber else {
                return
            }
            
            
            guard let result = storedAction.calculate(storedNumber, state.currentNumber) else {
                return
            }
                
            
            state.currentNumber = result
            state.storedNumber = nil
            state.storedAction = nil
            
            break
            
            //Percent button is pressed
        case .percent:

            
            state.currentNumber = state.currentNumber * 0.01
            
        default:
            
            state.storedNumber = state.currentNumber            
            state.currentNumber = 0
            state.storedAction = action
            
            break
        }
    }
    
}
