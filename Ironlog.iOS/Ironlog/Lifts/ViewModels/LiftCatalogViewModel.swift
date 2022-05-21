//
//  LiftCatalogViewModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation
class LiftCatalogViewModel : ObservableObject {
    
    @Published var lifts: [Lift]
    
    private var liftRepository: LiftRepository
    
    init(liftRepository: LiftRepository) {
        self.liftRepository = liftRepository
        self.lifts = []
    }
    
    func loadLifts() throws {
        lifts = try liftRepository.getAllLifts()
    }
    
    func deleteLifts(indexSet: IndexSet) throws {
        for index in indexSet {
            let liftId = lifts[index].id
            
            try liftRepository.deleteLift(liftId: liftId)
            
            lifts.remove(at: index)
        }
    }
    
}
