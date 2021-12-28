//
//  LiftCatalog.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import Foundation

class LiftCatalog: ObservableObject {
    @Published var lifts: [Lift]
    
    init() {
        lifts = []
    }
    
    init(initialLifts startingLifts: [Lift]) {
        self.lifts = startingLifts
    }
    
    func addLift(liftToAdd: Lift) {
        self.lifts.append(liftToAdd)
    }
    
    func deleteLift(liftToDelete: Lift) {
        self.lifts = self.lifts.filter { $0.id != liftToDelete.id}
    }
    
    func deleteIndexes(indexes: IndexSet) {
        self.lifts.remove(atOffsets: indexes)
    }
}
