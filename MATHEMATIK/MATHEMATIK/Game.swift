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

struct Game {
    var score = 0
    var firstNumber = 0
    var secondNumber = 0
    var timeRemaining = 180
    var totalTime = 0
    var loseGame = false
    var choiceArray = [Int]()
    var operationSymbol: String = "+"
    var correctAnswer = 0
    var difficulty: Difficulty


    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        generateOptions()
    }
    
    init() {
        self.difficulty = .beginner
    }
    

   /* mutating func generateOptions() {
        let operation = selectOperation()
        (self.firstNumber, self.secondNumber, self.correctAnswer) = performOperation(using: operation)

        var optionsList = [self.correctAnswer]

        while optionsList.count < 4 {
            let adjustment = Int.random(in: 1...10)
            let adjustedOption = self.correctAnswer + (Bool.random() ? adjustment : -adjustment)

            if !optionsList.contains(adjustedOption) {
                optionsList.append(adjustedOption)
            }
        }
        self.choiceArray = optionsList.shuffled()
    }
    */

    mutating func generateOptions() {
        let operation = selectOperation()
        (self.firstNumber, self.secondNumber, self.correctAnswer) = performOperation(using: operation)

        var optionsList = Set<Int>()
        optionsList.insert(self.correctAnswer)

        while optionsList.count < 4 {
            let adjustment = Int.random(in: 1...10)
            let adjustedOption = self.correctAnswer + (Bool.random() ? adjustment : -adjustment)
            optionsList.insert(adjustedOption)
        }
        self.choiceArray = Array(optionsList).shuffled()
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

    mutating func performOperation(using operation: (Int, Int) -> (Int, String)) -> (Int, Int, Int) {
        self.firstNumber = Int.random(in: 1...100)
        self.secondNumber = Int.random(in: 1...100)
        let (result, symbol) = operation(self.firstNumber, self.secondNumber)
        operationSymbol = symbol
        return (self.firstNumber, self.secondNumber, result)
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
        

    mutating func optionIsCorrect(option: Int) {
        if option == self.correctAnswer {
            self.score += 1
            print("Score updated to \(self.score)")
            self.generateOptions()
            if self.timeRemaining < 180 {
                self.timeRemaining += 5
            }
        } else {
            self.loseGame = true
        }
    }


   
}


