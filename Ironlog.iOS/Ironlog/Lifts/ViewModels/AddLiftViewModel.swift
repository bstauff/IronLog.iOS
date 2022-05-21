//
//  AddLiftViewModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation

class AddLiftViewModel : ObservableObject {
    @Published var liftName: String?
    @Published var trainingMax: Int?
    
    private let liftRepo: LiftRepository
    
    init(liftRepo: LiftRepository) {
        self.liftRepo = liftRepo
    }
    
    func addLift() throws {
        
        guard liftName != nil else {
            throw AddLiftViewModelErrors.noLiftNameGiven
        }
        
        guard trainingMax != nil else {
            throw AddLiftViewModelErrors.noTrainingMaxGiven
        }
        
        let newLift = Lift(name: liftName!, trainingMax: trainingMax!)
            
        do {
            try liftRepo.addLift(lift: newLift)
        }catch {
            throw AddLiftViewModelErrors.addingLiftFailed
        }
    }
}

enum AddLiftViewModelErrors : Error {
    case noLiftNameGiven
    case noTrainingMaxGiven
    case addingLiftFailed
}
