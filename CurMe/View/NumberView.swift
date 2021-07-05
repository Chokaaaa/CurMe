//
//  NumberView.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 27/06/2021.
//

import SwiftUI

struct NumberView: View {
    
    //MARK: - Properties
    
    let number: Double
    @Binding var state: CalculationState
    
    var numberString: String {
        
        if number == .pi {
            return "𝝅"
        }
       return String(Int(number))
    }
    
    //MARK: - Body
    var body: some View {
        Text(numberString)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .background(Color.gray)
            .cornerRadius(40)
            .onTapGesture {
                self.state.appendNumber(self.number)
            }
    }
}
