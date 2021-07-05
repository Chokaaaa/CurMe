//
//  ContentView.swift
//  CurMe
//
//  Created by Nursultan Yelemessov on 25/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Home()
            }
        }
    }
}
