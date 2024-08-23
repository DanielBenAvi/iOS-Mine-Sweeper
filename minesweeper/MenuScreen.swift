//
//  ContentView.swift
//  minesweeper
//
//  Created by דניאל בן אבי on 21/08/2024.
//

import SwiftUI

struct MenuScreen: View {
    @State private var navigateToGame = false
    @State private var size: Double = 8

    var body: some View {
        NavigationStack{
            VStack {
                Text("Mine Sweeper")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                Button(action: startGame) {
                    Text("Start Game")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                }
            }
            .navigationBarBackButtonHidden()
            .padding()
            .navigationDestination(isPresented: $navigateToGame) {
                GameScreen()
            }
        }
    }

    func startGame() {
        navigateToGame = true
    }
}



#Preview {
    MenuScreen()
}
