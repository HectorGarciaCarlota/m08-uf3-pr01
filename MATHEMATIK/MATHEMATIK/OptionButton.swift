//
//  OptionButton.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

struct OptionButton: View {
    var number: Int
    
    var body: some View {
        Text("\(number)")
            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .font(.custom("Poppins-Bold", size: 20)) // i think that with 20 should be enough to not cut numbers...
            .foregroundColor(Color.black)
            .background(
                LinearGradient(
                stops: [
                Gradient.Stop(color: Color(red: 0.39, green: 0.71, blue: 1).opacity(0.5), location: 0.85),
                Gradient.Stop(color: Color(red: 0.05, green: 0.34, blue: 0.6).opacity(0.5), location: 1.00),
                ],
                startPoint: UnitPoint(x: 3.03, y: -0.74),
                endPoint: UnitPoint(x: 0.5, y: 1)
                )
                )
            .clipShape(Circle())
            .padding()
    }
}

struct OptionButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionButton(number: 100)
    }
}
