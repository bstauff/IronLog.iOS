//
//  Lift.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import Foundation

class Lift : Hashable, Identifiable, ObservableObject {
    var id : UUID
    @Published var liftName: String
    @Published var trainingMax: Int
    
    init(liftName: String, trainingMax: Int) {
        self.id = UUID()
        self.liftName = liftName
        self.trainingMax = trainingMax
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Lift, rhs: Lift) -> Bool {
        return lhs.id == rhs.id
    }
    
}
