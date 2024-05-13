//
//  ContentView.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: GameStore

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Welcome to MATHEMATIK, challenge yourself")
                    .font(.custom("Poppins-SemiBold", size: 20))
                    .padding()
                    .frame(width: geometry.size.width - 40, alignment: .leading)
                
                Text("Choose a difficulty")
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color(hex: 0x4894FE))
                    .padding(.bottom)
                
                DifficultyButton(text: "Beginner", action: {
                    viewModel.selectDifficulty(.beginner)
                })
                
                DifficultyButton(text: "Intermediate", action: {
                    viewModel.selectDifficulty(.intermediate)
                })
                
                VStack(alignment: .leading) {
                    Text("TOP SCORES")
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .padding(.top, 20)
                    
                    HStack {
                        Text("N°")
                            .frame(width: 30, alignment: .leading)
                        Text("Score")
                            .frame(width: 60, alignment: .leading)
                        Text("Minutes alive")
                            .frame(width: 100, alignment: .leading)
                    }
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .padding(.bottom, 5)
                    
                    List {
                        ForEach(Array(viewModel.coreDataViewModel.topScores.enumerated()), id: \.offset) { index, gameScore in
                            HStack {
                                Text("\(index + 1).")
                                    .frame(width: 30, alignment: .leading)
                                Text("\(gameScore.score)")
                                    .frame(width: 60, alignment: .leading)
                                Text("\(formatTime(seconds: Int(gameScore.timeSurvived))) min")
                                    .frame(width: 100, alignment: .leading)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: 300)
                }
                .padding()
            }
            .padding()
            .onAppear {
                viewModel.coreDataViewModel.fetchTop10GameScores()
            }
            .fullScreenCover(isPresented: $viewModel.isShowingGameView) {
                GameView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct DifficultyButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 14))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            Gradient.Stop(color: Color(red: 0.23, green: 0.42, blue: 0.6).opacity(0.2), location: 0.0),
                            Gradient.Stop(color: Color(red: 0.39, green: 0.71, blue: 1).opacity(0.2), location: 1.0)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(100)
        }
        .padding()
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameStore(coreDataViewModel: CoreDataViewModel()))
            .environmentObject(CoreDataViewModel())
    }
}

