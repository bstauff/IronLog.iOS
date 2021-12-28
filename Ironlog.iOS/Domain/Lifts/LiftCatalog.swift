//
//  LiftCatalog.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class LiftCatalog : ObservableObject {
    var id: UUID
    @Published var lifts: [Lift]
    
    init() {
        self.id = UUID()
        self.lifts = []
    }
    
    func getLift(liftId: UUID) -> Lift {
        return lifts.first(where: {(lift: Lift) -> Bool in
            return lift.id == liftId
        })!
    }
}
