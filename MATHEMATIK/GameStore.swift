//
//  GameStore.swift
//  MATHEMATIK
//
//  Created by PEDRO on 5/5/24.
//

import Foundation

class GameStore: ObservableObject {
    @Published var selectedDifficulty: Difficulty = .beginner
    @Published var isShowingGameView = false
    @Published var game: Game?
    
    func selectDifficulty(_ difficulty: Difficulty) {
        selectedDifficulty = difficulty
        isShowingGameView = true
        game = Game(difficulty: difficulty)
    }
}
