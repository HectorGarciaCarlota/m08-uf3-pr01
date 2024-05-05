//
//  Game.swift
//  MATHEMATIK
//
//  Created by PEDRO on 5/5/24.
//

import Foundation
import Combine

enum Difficulty: Identifiable {
    case beginner, intermediate

    var id: Self { self }
}

class Game: ObservableObject {
    @Published var score = 0
    @Published var firstNumber = 0
    @Published var secondNumber = 0
    @Published var choiceArray = [Int]()
    @Published var loseGame = false
    @Published var operationSymbol: String = "+"
    @Published var timeRemaining = 180
    var correctAnswer = 0
    var difficulty: Difficulty
    var timer: AnyCancellable?

    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        generateOptions()
        startTimer()
    }
    

    func generateOptions() {
        let operation = selectOperation()
        (firstNumber, secondNumber, correctAnswer) = performOperation(using: operation)

        var optionsList = [correctAnswer]

        while optionsList.count < 4 {
            let adjustment = Int(Double(correctAnswer) * (Double.random(in: 0.05...0.10)))
            let adjustedOption = correctAnswer + (Bool.random() ? adjustment : -adjustment)

            if !optionsList.contains(adjustedOption) {
                optionsList.append(adjustedOption)
            }
        }
        choiceArray = optionsList.shuffled()
    }



    func selectOperation() -> ((Int, Int) -> (Int, String)) {
        let operations: [(Int, Int) -> (Int, String)]
        switch difficulty {
        case .beginner:
            operations = [add, subtract, multiply]
        case .intermediate:
            operations = [add, subtract, multiply, divide]
        }
        return operations.randomElement() ?? add
    }

    func performOperation(using operation: (Int, Int) -> (Int, String)) -> (Int, Int, Int) {
        firstNumber = Int.random(in: 0...100)
        secondNumber = Int.random(in: 0...100)
        let (result, symbol) = operation(firstNumber, secondNumber)
        operationSymbol = symbol
        return (firstNumber, secondNumber, result)
    }

    func add(_ a: Int, _ b: Int) -> (Int, String) {
        return (a + b, "+")
    }
    func subtract(_ a: Int, _ b: Int) -> (Int, String) {
        return (a - b, "-")
    }
    func multiply(_ a: Int, _ b: Int) -> (Int, String) {
        return (a * b, "*")
    }
    func divide(_ a: Int, _ b: Int) -> (Int, String) {
        return (b != 0 ? a / b : add(a, b).0, "/")
    }


    func optionIsCorrect(option: Int) {
        if option == correctAnswer {
            score += 1
            generateOptions()
        } else {
            loseGame = true
            stopTimer()
        }
    }

    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.tick()
        }
    }

    func stopTimer() {
        timer?.cancel()
    }

    func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            loseGame = true
            stopTimer()
        }
    }

    deinit {
        stopTimer()
    }
}


