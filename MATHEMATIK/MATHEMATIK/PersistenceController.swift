//
//  PersistenceController.swift
//  MATHEMATIK
//
//  Created by PEDRO on 13/5/24.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var topScores: [OwO] = []

    init() {
        container = NSPersistentContainer(name: "GameScoress")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("yippie")
                self.fetchTop10GameScores()
            }
        }
    }

    func saveGameScore(score: Int32, timeRemaining: Int32) {
        let context = container.viewContext
        let newGameScore = OwO(context: context)
        newGameScore.score = score
        newGameScore.timeSurvived = timeRemaining
        
        do {
            try context.save()
            print("XD")
            fetchTop10GameScores()
        } catch {
            print("Failed to save game score: \(error.localizedDescription)")
        }
    }

    func fetchTop10GameScores() {
        let context = container.viewContext
        let request: NSFetchRequest<OwO> = OwO.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = 10
        
        do {
            self.topScores = try context.fetch(request)
        } catch {
            print("Failed to fetch game scores: \(error.localizedDescription)")
            self.topScores = []
        }
    }
}
