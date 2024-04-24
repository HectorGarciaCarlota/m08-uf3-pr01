//
//  GameView.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

struct GameView: View {
    @State private var correctAnswer = 0
    @State private var choiceArray = [ 0, 1, 2, 3 ]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var difficulty = 100 // Gotta remove this -4º
    @State private var score = 0
    @State private var loseGame = false
    
    var body: some View {
        // VStack(alignment: .leading) {
        VStack {
            Text("Current score: \(self.score)")
                .font(.headline)
                .bold()
            
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber)")
                .font(.largeTitle)
                .bold()
            
            HStack {
                ForEach(0..<2) { i in
                    Button {
                        optionIsCorrect(option: choiceArray[i])
                        generateOptions()
                    } label: {
                        OptionButton(number: choiceArray[i])
                    }
                }
            }
            
            HStack {
                ForEach(2..<4) { i in
                    Button {
                        optionIsCorrect(option: choiceArray[i])
                        generateOptions()
                    } label: {
                        OptionButton(number: choiceArray[i])
                    }
                }
            }
            
            Spacer()
        }.alert(isPresented: $loseGame, content: {
            Alert(title: Text("Loser!"), message: Text("You have lost this game, your score is: \(self.score)"), dismissButton: .default(Text("OK")))
        })
    }
    
    func optionIsCorrect(option: Int) {
        // self.score = option == correctAnswer ? self.score + 1 : self.score - 1
        
        if option == correctAnswer {
            self.score += 1
        } else {
            self.loseGame = true
        }
    }
    
    func generateOptions() {
        firstNumber = Int.random(in: 0...(difficulty / 2))
        secondNumber = Int.random(in: 0...(difficulty / 2))
        
        var optionsList = [Int]()
        
        correctAnswer = firstNumber + secondNumber
        
        for _ in 0...2 {
            optionsList.append(Int.random(in: 0...difficulty))
        }
        
        optionsList.append(correctAnswer)
        
        choiceArray = optionsList.shuffled()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
