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
    let coreDataViewModel: CoreDataViewModel
        
        init(coreDataViewModel: CoreDataViewModel) {
            self.coreDataViewModel = coreDataViewModel
        }
    
    func selectDifficulty(_ difficulty: Difficulty) {
        selectedDifficulty = difficulty
        isShowingGameView = true
        game = Game(difficulty: difficulty)
        
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink() {_ in 
            self.tick()
            self.tickAsc()
        }
    }

    func saveGame() {
        coreDataViewModel.saveGameScore(score: Int32(game.score), timeRemaining: Int32(game.totalTime))
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
    
    func tickAsc() {
        if self.game.loseGame == false {
            self.game.totalTime += 1
        }
    }
}
