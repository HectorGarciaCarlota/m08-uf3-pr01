//
//  MATHEMATIKApp.swift
//  MATHEMATIK
//
//  Created by alumne on 24/04/2024.
//

import SwiftUI

@main
struct MATHEMATIKApp: App {
//    @StateObject private var coreDataViewModel = CoreDataViewModel()
    @StateObject private var gameStore: GameStore

    init() {
        let coreDataViewModel = CoreDataViewModel()
        _gameStore = StateObject(wrappedValue: GameStore(coreDataViewModel: coreDataViewModel))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameStore)
//                .environmentObject(coreDataViewModel)
        }
    }
}

