//
//  GameScreen.swift
//  minesweeper
//
//  Created by דניאל בן אבי on 21/08/2024.
//

import Foundation
import SwiftUI

struct GameScreen: View {
    @StateObject var gm: GameManager = GameManager()
    @State private var navigateToEnd = false
    @State private var counter: Int = 0
    @State private var isRunning: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var actions = 0
    @State var passedActions = 0

    var body: some View {
        NavigationStack {
            VStack {
                Text("Mine Sweeper")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text(formatCounter(counter))
                Spacer()
                VStack {
                    ForEach(0..<gm.board.count, id: \.self) { y in
                        HStack {
                            ForEach(0..<gm.board[0].count, id: \.self) { x in
                                Text(gm.getCellText(y: y, x: x))
                                    .frame(width: 30, height: 30)
                                    .background(gm.mask[y][x] ? Color.gray.opacity(0.2) : Color.white)
                                    .onTapGesture {
                                        click(y:y , x:x)
                                    }
                            }
                        }
                    }
                }
                Spacer()
                Button {
                    if (!gm.gameOver){
                        resetGame()
                    } else {
                        endGame()
                    }
                } label: {
                    Text(gm.gameOver ? "End Game" : "Reset")
                }.buttonStyle(BorderedButtonStyle())
            }
            .navigationBarBackButtonHidden()
            .padding()
            .navigationDestination(isPresented: $navigateToEnd) {
                EndScreen(time: counter, steps: passedActions ,title: gm.checkWin() ? "You Won!"  : "You Lost!")
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                if (gm.gameOver) {
                    stopCounter()
                } else {
                    counter += 1
                }
             }
         }

    }
    
    //MARK: Functions
    func click(y: Int, x: Int) {
        if (gm.gameOver){return}
        
        if (actions == 0) {
            startCounter()
        }
        
        actions = actions + 1
        
        gm.click(y: y, x: x)
        
        if (gm.checkWin()) {
            gm.gameOver.toggle()
        }
        
    }
    
    func resetGame(){
        gm.resetBoard()
        resetCounter()
        passedActions = actions
        actions = 0
    }
    
    func endGame() {
        stopCounter()
        navigateToEnd = true
        passedActions = actions
        actions = 0
    }
    
    
    //MARK: Counter
    func startCounter() {
        isRunning = true
    }
    
    func stopCounter() {
        isRunning = false
    }
    
    func resetCounter() {
        isRunning = false
        counter = 0
    }
    
    func formatCounter(_ counter: Int) -> String {
        let minutes = counter / 60
        let seconds = counter % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    GameScreen()
}
