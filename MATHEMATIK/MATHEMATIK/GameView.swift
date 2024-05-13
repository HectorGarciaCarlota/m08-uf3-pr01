//
//  GameView.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var viewModel: GameStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Current score: \(viewModel.game.score)")
                .font(.custom("Poppins-SemiBold", size: 24))
                .frame(width: 360, alignment: .topLeading)
                .onAppear {
                    print("Score appearing with value: \(viewModel.game.score)")
                }
            
            Text(formatTime(seconds: viewModel.game.timeRemaining))
                .font(.custom("Poppins-SemiBold", size: 32))
                .foregroundColor(.white)
                .frame(height: 20)
            
            Text("\(viewModel.game.firstNumber) \(viewModel.game.operationSymbol) \(viewModel.game.secondNumber)")
                .font(.custom("Poppins-Bold", size: 48))
                .bold()
                .padding(.top, 60)
            
            VStack(spacing: 20) {
                HStack {
                    ForEach(0..<2, id: \.self) { i in
                        Button {
                            viewModel.game.optionIsCorrect(option: viewModel.game.choiceArray[i])
                        } label: {
                            OptionButton(number: viewModel.game.choiceArray[i])
                        }
                    }
                }
                
                HStack {
                    ForEach(2..<4, id: \.self) { i in
                        Button {
                            viewModel.game.optionIsCorrect(option: viewModel.game.choiceArray[i])
                        } label: {
                            OptionButton(number: viewModel.game.choiceArray[i])
                        }
                    }
                }
            }
            Spacer()
        }.onAppear {
            viewModel.startTimer()
            }.alert(isPresented: $viewModel.game.loseGame) {Alert(
                title: Text("You Lose!"),
                message: Text("Better luck next time."),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.saveGame()
                    presentationMode.wrappedValue.dismiss()
                    viewModel.isShowingGameView = false
                })
            )
        }
    }
    
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
// Preview commented out because it expects a Game instance
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView().environmentObject(GameStore())
//    }
//}
