//
//  ContentView.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameStore()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Welcome to mathematiks, challenge yourself")
                    .font(.custom("Poppins-SemiBold", size: 30))
                    .padding()
                    .frame(width: geometry.size.width, alignment: .topLeading)
            
                
                Text("Choose a difficulty")
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color(hex: 0x4894FE))
                
                Button(action: {
                    viewModel.selectDifficulty(.beginner)
                }) {
                    Text("Beginner")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 14))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                gradient: Gradient(	stops: [
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
                Button(action: {
                    viewModel.selectDifficulty(.intermediate)
                }) {
                    Text("Intermediate")
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
          .fullScreenCover(isPresented: $viewModel.isShowingGameView) {
              if let game = viewModel.game {
                  GameView(game: game)
              } else {
                  Text("Difficulty not set")
              }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
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
    }
}
