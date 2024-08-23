//
//  GameManager.swift
//  minesweeper
//
//  Created by דניאל בן אבי on 22/08/2024.
//

import Foundation
import SwiftUI

class GameManager: ObservableObject {
    let rows = 9
    let cols = 9
    let bombs = 8
    @Published var gameOver = false
    @Published var board: [[Int]] = [[]]
    @Published var mask: [[Bool]] = [[]]
    
    init() {
        resetBoard()
    }
    
    func initBombs() {
        var placedBombs = bombs
        
        while placedBombs > 0 {
            let randomX = Int.random(in: 0...cols-1)
            let randomY = Int.random(in: 0...rows-1)
            
            if board[randomX][randomY] == 0 {
                board[randomX][randomY] = -1
                placedBombs = placedBombs - 1
            }
        }
    }
    
    func initNumbers() {
        let directions = [
            (-1, -1),   (-1, 0),    (-1, 1),
            (0, -1),                (0, 1),
            (1, -1),    (1, 0),     (1, 1)
        ]
        
        for y in 0..<cols {
            for x in 0..<rows {
                if board[y][x] == -1 {  // Found a bomb
                    for direction in directions {
                        let newY = y + direction.0
                        let newX = x + direction.1
                        
                        // Ensure the new coordinates are within bounds
                        if newY >= 0 && newY < cols && newX >= 0 && newX < rows {
                            if board[newY][newX] != -1 { // Don't increment if it's also a bomb
                                board[newY][newX] += 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getCellText(y: Int, x: Int) -> String {
        if(mask[y][x]) { // invisible
            return " "
        } else { // visible
            if(board[y][x] == -1) {
                return "💣"
            } else if (board[y][x] == 0){
                return ""
            } else {
                return "\(board[y][x])"
            }
        }
    }
    
    func resetBoard() {
        gameOver = false            

        board = Array(repeating: Array(repeating: 0, count: cols), count: rows)
        mask = Array(repeating: Array(repeating: true, count: cols), count: rows)

        initBombs()
        initNumbers()
    }
    
    func click(y: Int, x: Int) {
        guard y >= 0 && y < cols && x >= 0 && x < rows else { return }

        if !mask[y][x] {
            return
        }

        mask[y][x] = false

        if board[y][x] == -1 {
            gameOver = true
            return
        }

        if board[y][x] == 0 {
            for direction in [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)] {
                let newY = y + direction.0
                let newX = x + direction.1
                click(y: newY, x: newX) 
            }
        }
    }
    
    func checkWin() -> Bool {
        for y in 0..<cols {
            for x in 0..<rows {
                if board[y][x] != -1 && mask[y][x] {
                    return false
                }
            }
        }
        return true
    }
}


