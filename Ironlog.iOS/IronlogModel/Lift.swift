//
//  Lift.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import Foundation

struct Lift : Identifiable, Hashable {
    
    var id : UUID
    var liftName: String
    var trainingMax: Int
    
    init(liftName: String, trainingMax: Int, id: UUID? = nil) {
        self.id = id ?? UUID()
        self.liftName = liftName
        self.trainingMax = trainingMax
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Lift, rhs: Lift) -> Bool {
        lhs.id == rhs.id
    }
}
