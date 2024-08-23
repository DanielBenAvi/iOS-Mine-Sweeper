//
//  EndScreen.swift
//  minesweeper
//
//  Created by דניאל בן אבי on 22/08/2024.
//

import Foundation
import SwiftUI

struct EndScreen: View {
    let time: Int
    let steps: Int
    let title: String
    @State private var navigateToMenu = false

    
    var body: some View {
        NavigationStack{
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Time to Complete: \(formatCounter(time))")
                    .font(.title)
                Text("With \(steps) actions")
                    .font(.title)
                Spacer()
                Spacer()
                Spacer()
                Button {
                    navigateToMenu = true
                } label: {
                    Text("Menu")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: 30)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
            }
            .navigationBarBackButtonHidden()
            .padding()
            .navigationDestination(isPresented: $navigateToMenu) {
                MenuScreen()
            }
        }
    }
    
    func formatCounter(_ counter: Int) -> String {
        let minutes = counter / 60
        let seconds = counter % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    EndScreen(time: 60, steps: 10, title: "You Won!")
}

