//
//  Lift.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class Lift : ObservableObject, Identifiable, Hashable {
    
    var id: UUID
    @Published var name: String
    @Published var trainingMax: Int
    
    init(name: String, trainingMax: Int) {
        self.name = name
        self.trainingMax = trainingMax
        self.id = UUID()
    }
    
    init(name: String, trainingMax: Int, id: UUID) {
        self.name = name
        self.trainingMax = trainingMax
        self.id = id
    }
    
    static func == (lhs: Lift, rhs: Lift) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(trainingMax)
    }
    
    
}
