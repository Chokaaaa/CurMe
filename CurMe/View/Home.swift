//
//  Home.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 25/06/2021.
//

import SwiftUI


struct CalculationState {
    
    var previousNumber: Double = 0
    var currentNumber: Double = 0
    let characterLimit = 7
    var storedNumber: Double?
    var initialValue: Double?
    var storedAction: ActionView.Action?
//    var circleBorder: Bool
//    var currencyLight: Bool
//    var tappedAgain : Bool
        
   mutating func appendNumber(_ number: Double) {
        if number.truncatingRemainder(dividingBy: 1) == 0 && currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
            currentNumber = 10 * currentNumber + number
        } else {
            currentNumber = number
        }
    
    }
}

struct Home: View {
        
    //MARK: - Properties
    @StateObject var viewModel = FetchData()
    @State var state = CalculationState()
    

    
    let characterLimit = 11
    
    
////    MARK: - Computed propety
//    var displayedString: String {
//        return String(String(format: "%.f",arguments: [state.currentNumber]).prefix(characterLimit))
//    }
    
    
    
//Suggested solution for spacing as per https://stackoverflow.com/questions/68870382/how-to-create-a-spacing-between-digits-in-stringformat-f-like-in-calculat/68870432?noredirect=1#comment121714558_68870432
    
    var displayedString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        return String((formatter.string(for: state.currentNumber) ?? ""))
    }
    
    
    
    //MARK: - Body
    var body: some View {
    
        //View of Number Pad
        VStack(alignment: .trailing, spacing: 20) {
            //            Spacer()
            
            Text(displayedString)
                
                .font(.system(size: 72))
                .foregroundColor(.white)
                .lineLimit(1)
                .padding(.bottom)
                
                //Minimum scale Factor suggestion but as long as i create turn on the minimum scale factor and the prefix of character limit my string is giving a weird outcome.
                
                .minimumScaleFactor(0.1)

                //As soon as i have changed the string format to a formatter after the spacing my swipe gesture dont work after the spacing.
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.width < 0 {
                                    // Swipe Left
                                    state.currentNumber = Double(displayedString.dropLast()) ?? 0
                                }
                                if value.translation.width > 0 {
                                    // Swipe right.
                                    state.currentNumber = Double(displayedString.dropLast()) ?? 0
                                }
                            }))
            
            HStack {
                CurrencyView(function: .Kazakhstan, state: $state)
                Spacer()
                CurrencyView(function: .Dirhams, state: $state)
                Spacer()
                CurrencyView(function: .Usa, state: $state)
                Spacer()
                ActionView(action: .clear, state: $state)
            }
            HStack {
                NumberView(number: 7, state: $state)
                Spacer()
                NumberView(number: 8, state: $state)
                Spacer()
                NumberView(number: 9, state: $state)
                Spacer()
                ActionView(action: .divide, state: $state)
                
            }
            HStack {
                NumberView(number: 4, state: $state)
                Spacer()
                NumberView(number: 5, state: $state)
                Spacer()
                NumberView(number: 6, state: $state)
                Spacer()
                ActionView(action: .multiply, state: $state)
                
            }
            HStack {
                NumberView(number: 1, state: $state)
                Spacer()
                NumberView(number: 2, state: $state)
                Spacer()
                NumberView(number: 3, state: $state)
                Spacer()
                ActionView(action: .minus, state: $state)
                
            }
            HStack {
                NumberView(number: 0, state: $state)
                Spacer()
                ActionView(action: .equal, state: $state)
                
                Spacer()
                //Percent below
                ActionView(action: .percent, state: $state)
                Spacer()
                //Equality below
                ActionView(action: .plus, state: $state)
            }
   
        }.padding(22)
        //Get Base code conversion data
        .onAppear{
            viewModel.updateData(baseCode: viewModel.baseCode)
        }
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
                    .foregroundColor(Color(#colorLiteral(red: 0.7871891856, green: 0.2050432563, blue: 0.007431099191, alpha: 1)))
            }
        }) //End of Toolbar
        
        
            
    }
}


//MARK: - Preview
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 11")
        }
    }
}



