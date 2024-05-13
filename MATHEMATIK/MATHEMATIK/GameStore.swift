//
//  GameStore.swift
//  MATHEMATIK
//
//  Created by PEDRO on 5/5/24.
//

import Foundation
import Combine

class GameStore: ObservableObject {
    @Published var selectedDifficulty: Difficulty = .beginner
    @Published var isShowingGameView = false
    @Published var game = Game()
    var timer: AnyCancellable?
    
    func selectDifficulty(_ difficulty: Difficulty) {
        selectedDifficulty = difficulty
        isShowingGameView = true
        game = Game(difficulty: difficulty)
        
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink() {_ in 
            self.tick()
        }
    }


    func stopTimer() {
        self.timer?.cancel()
    }

    func tick() {
        if self.game.timeRemaining > 0 {
            self.game.timeRemaining -= 1
        } else {
            self.game.loseGame = true
            self.stopTimer()
        }
    }
}
