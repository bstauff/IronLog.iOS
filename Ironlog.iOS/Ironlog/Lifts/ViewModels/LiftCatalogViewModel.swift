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
    
    func loadLifts() throws {
        
    }
    
}
