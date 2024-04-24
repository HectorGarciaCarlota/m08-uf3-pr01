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
            .font(.system(size: 40, weight: .bold))
            .foregroundColor(Color.white)
            .background(Color.blue)
            .clipShape(Circle())
            .padding()
    }
}

struct OptionButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionButton(number: 100)
    }
}
