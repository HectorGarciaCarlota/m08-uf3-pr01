//
//  GameView.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: Game
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30){
            Text("Current score: \(game.score)")
                .font(.custom("Poppins-SemiBold", size: 24))
                .frame(width: 360, alignment: .topLeading)
            
            Text(formatTime(seconds: game.timeRemaining))
                            .font(.custom("Poppins-SemiBold", size: 32))
                            .foregroundColor(.black)
                            .frame(height: 20)
            
            
            Text("\(game.firstNumber) \(game.operationSymbol) \(game.secondNumber)")
                .font(.custom("Poppins-Bold", size: 48))
                .bold()
                .padding(.top, 60)
            
            
            VStack(spacing: 20) {
                HStack {
                    ForEach(0..<2, id: \.self) { i in
                        Button {
                            game.optionIsCorrect(option: game.choiceArray[i])
                        } label: {
                            OptionButton(number: game.choiceArray[i])
                        }
                    }
                }
                
                HStack {
                    ForEach(2..<4, id: \.self) { i in
                        Button {
                            game.optionIsCorrect(option: game.choiceArray[i])
                        } label: {
                            OptionButton(number: game.choiceArray[i])
                        }
                    }
                }
            }
            Spacer()
        }.alert(isPresented: $game.loseGame, content: {
            Alert(title: Text("Loser!"), message: Text("You have lost this game, your score is: \(game.score)"), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        })
    }
    
    func formatTime(seconds: Int) -> String {
            let minutes = seconds / 60
            let seconds = seconds % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game(difficulty: .beginner))
    }
}
