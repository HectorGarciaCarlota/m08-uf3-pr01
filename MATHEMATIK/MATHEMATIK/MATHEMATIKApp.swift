//
//  MATHEMATIKApp.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

@main
struct MATHEMATIKApp: App {
    @StateObject var viewModel = GameStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
