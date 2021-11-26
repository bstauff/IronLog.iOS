//
//  MovementCollection.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/25/21.
//

import Foundation

struct MovementCatalog {
    private var movements : Set<Movement>
    
    init() {
        self.movements = Set<Movement>()
    }
    
    init(initialMovements movements: Set<Movement>) {
        self.movements = movements
    }
    
    mutating func addMovement(movementToAdd newMovement: Movement) {
        movements.insert(newMovement)
    }
    
    mutating func removeMovement(movementToRemove movement: Movement) {
        movements.remove(movement)
    }
}
