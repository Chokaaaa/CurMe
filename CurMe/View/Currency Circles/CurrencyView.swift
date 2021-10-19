//
//  CurrencyView.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 27/06/2021.
//

//




import SwiftUI

struct CurrencyView: View {
    
    enum currencyChoice {
        case Kazakhstan, Rubles, Usa, Dirhams
        
        func image() -> Image {
            switch self {
            
            case .Kazakhstan:  return Image("kz")
                
            case .Rubles:      return Image("rub")
                
            case .Usa:         return Image("usa")
                
            case .Dirhams:      return Image("aed")
            
            }
        }
        
        
        func currentChoiceOfCase() {
            @State var CurrencyLight : Bool = false
            @State var CircleBorder: Bool = false
            
            switch self {
            case .Kazakhstan:
                CircleBorder = true
                CurrencyLight = true
            case .Rubles:
                CircleBorder = true
                CurrencyLight = true
            case .Usa:
                CircleBorder = true
                CurrencyLight = true
            case .Dirhams:
                CircleBorder = true
                CurrencyLight = true
            }
        }
        
        func operation(_ input: Double) -> Double {
            
            //MARK: - Properties
            @Binding var state : CalculationState
   
            @State var showAlert : Bool = false
            
            //MARK: - Switch Statement
            switch self {
            case .Kazakhstan:
                if let rates = FetchData.conversionData?.rates["KZT"] {
                    
                    
//                    print(rates)
                    return (input * Double(rates))
                }else{
                    //Show error Alert
                    print("Something went wrong")
                    return input
                }
            case .Rubles:
                if let rates = FetchData.conversionData?.rates["RUB"] {
//                    print(rates)
                    return (input * Double(rates))
                }else{
                    //Show error Alert
                    print("Something went wrong")
                    return input
                }
            case .Usa:
                if let rates = FetchData.conversionData?.rates["USD"] {
//                    print(rates)
                    return (input * Double(rates))
                }else{
                    //Show error Alert
                    print("Something went wrong")
                    return input
                }
                
            case  .Dirhams:
                if let rates = FetchData.conversionData?.rates["AED"] {
                    
//                    print(rates)
                    return (input * Double(rates))
                } else {
                    //Show error Alert
                    print("Something went wrong")
                    return input
                }

            }
            
            
        } //Function Enda
        
    }
    var function : currencyChoice
    @Binding var state : CalculationState
    @ObservedObject var monitor = NetworkMonitor()
    @State private var showingAlert = false
    @State var CurrencyLight : Bool = false
    @State var CircleBorder: Bool = false
    @State var tappedAgain: Bool = false


    
    var body: some View {
        ZStack {
            function.image()
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(40)
                .opacity(CurrencyLight ? 1 : 0.2)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(CircleBorder ? Color(#colorLiteral(red: 0.7915069461, green: 0.2042711377, blue: 0.01614261977, alpha: 1)) :Color.black , lineWidth: 3))
            
            
            
     
            .onTapGesture {
//                Checking the wifi connection and sending an alert in case if its disonnected.
                if monitor.isConnected == false {
                    showingAlert = true
                                }
                
                //MARK: - First time press
                if tappedAgain == false {
                CircleBorder = true
                CurrencyLight = true
                state.storedNumber = state.currentNumber
                    print(state.currentNumber)
                    state.currentNumber = function.operation(state.currentNumber)
                    print(state.currentNumber)
                tappedAgain.toggle()
//
//                    //MARK: - Second time press on the same circle.
                } else if tappedAgain == true {
                    //code needs to be added below
//
//                    //MARK: - Force unrwaping an optional value
                    if let chosenCur = state.storedNumber {
                        state.currentNumber = chosenCur
                        CircleBorder = false
                        CurrencyLight = false
                    } else {
                        CircleBorder = false
                        CurrencyLight = false
                        print("Somethings happening")
                    }
                    tappedAgain.toggle()
                }
//                Circle Apearance togle.

//                    CircleBorder.toggle()
//                    CurrencyLight.toggle()
//                    if tappedAgain == false {
//                        state.storedNumber = state.currentNumber
//                        state.currentNumber = function.operation(state.currentNumber)
//                        tappedAgain.toggle()
//                    } else {
//                        CurrencyLight = false
//                        CircleBorder = false
//                        tappedAgain.toggle()
//                        state.currentNumber = state.storedNumber!
//                        if CircleBorder == true {
//
//                        }
//
//                    }

                } //End of .onTapGesture
            
            
                .alert(isPresented: $showingAlert, content: {
                                return Alert(title: Text("Connect to Internet"), message: Text("Kindly Connect to internet to get the latest rates and use the application with accurate calculations"), dismissButton: .default(Text("Okay")))
                        }) //End of Allert

            
            
            
            
            
            
            
            
        //Context Menu to Add multiple Currency in the long press gesture.
//                .contextMenu {
//                    Button {
//                        print("Change Rate")
//                    } label : {
//                        Label("Eur", systemImage: "person.fill.checkmark")
//                    }
//                } https://www.youtube.com/watch?v=1kX0vA6SXBo just check out the link mentioned here.
//}
//
    }
}
}

