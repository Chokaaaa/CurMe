//
//  Home.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 25/06/2021.
//

import SwiftUI




struct CalculationState {
    var currentNumber: Double = 0
    
    
    var storedNumber: Double?
    var storedAction: ActionView.Action?
    
    
   mutating func appendNumber(_ number: Double) {
        if number.truncatingRemainder(dividingBy: 1) == 0 && currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
            currentNumber = 10 * currentNumber + number
            //
        } else {
            currentNumber = number
        }
    }
}

struct Home: View {
    
    
    //MARK: - Properties
    @StateObject var viewModel = FetchData()
    @State var state = CalculationState()
    
    //MARK: - Computed propety
    var displayedString: String {
        return String(format: "%.f", arguments: [state.currentNumber])
    }
    
    
    
    
    //MARK: - Body
    var body: some View {
//

//
//        VStack {
//            if viewModel.coversionData.isEmpty{
//
//                ProgressView()
//
//            } else {
//
//                ScrollView(showsIndicators: false) {
//                            LazyVStack(alignment: .leading, spacing: 15, content: {
//
//                                ForEach(viewModel.coversionData) {rate in
//
//                                    HStack(spacing: 15) {
//
//
//                                        Text(getFlag(currency: rate.currencyName))
//                                            .font(.system(size: 50))
//
//                                        VStack(alignment: .leading, spacing: 5, content: {
//                                            Text(rate.currencyName)
//                                                .font(.title)
//                                                .fontWeight(.bold)
//
//                                            Text("\(rate.currencyValue)")
//                                                .fontWeight(.heavy)
//                                        })
//                                    }
//                                    .padding(.horizontal)
//                                }
//
//                            })
//
//                        }
//
//            }

    
        //View of Number Pad
        VStack(alignment: .trailing, spacing: 20) {
//            Spacer()
            
            
        Text(displayedString)
            .font(.system(size: 75))
            .foregroundColor(.white)
            .lineLimit(3)
            .padding(.bottom)
            
            HStack {
                CurrencyView(function: .Kazakhstan, state: $state)
                Spacer()
                CurrencyView(function: .Rubles, state: $state)
                Spacer()
                CurrencyView(function: .Usa, state: $state)
                Spacer()
                ActionView(action: .divide, state: $state)
            }
            HStack {
                NumberView(number: 7, state: $state)
                Spacer()
                NumberView(number: 8, state: $state)
                Spacer()
                NumberView(number: 9, state: $state)
                Spacer()
                ActionView(action: .multiply, state: $state)
            }
            HStack {
                NumberView(number: 4, state: $state)
                Spacer()
                NumberView(number: 5, state: $state)
                Spacer()
                NumberView(number: 6, state: $state)
                Spacer()
                ActionView(action: .minus, state: $state)
            }
            HStack {
                NumberView(number: 1, state: $state)
                Spacer()
                NumberView(number: 2, state: $state)
                Spacer()
                NumberView(number: 3, state: $state)
                Spacer()
                ActionView(action: .plus, state: $state)
            }
            HStack {
                NumberView(number: 0, state: $state)
                Spacer()
                ActionView(action: .clear, state: $state)
                Spacer()
                //Percent below
                ActionView(action: .percent, state: $state)
                Spacer()
                //Equality below
                ActionView(action: .equal, state: $state)
            }
   
        }.padding(22)
    
        
        .toolbar(content: {
            Menu(content: {
                
                ForEach(currencies, id: \.self) { name in
                    Button(action: {
                        //some code here
                        viewModel.updateData(baseCode: name)
                    }, label: {
                        Text(name)
                    })
                }
                
            }) {
                
                Text("Main = \(viewModel.baseCode)")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .foregroundColor(.blue)
            }
        }) //End of Toolbar
            
    }
    
    
    //Code for representing of the flags we can even delete it.
    func getFlag(currency: String) -> String {


        let base_code = 127397

        var code = currency
        code.removeLast()



        var scalar = String.UnicodeScalarView()

        for i in code.utf16 {

            scalar.append(UnicodeScalar(base_code + Int(i))!)
        }

        return String(scalar)

    } //End of GetFlag function maybe will be deleted.
    
}

//Currency View






//MARK: - Preview
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}



