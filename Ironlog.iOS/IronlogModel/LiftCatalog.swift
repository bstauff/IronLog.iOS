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
}
