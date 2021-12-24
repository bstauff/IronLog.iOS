//
//  Lift.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import Foundation

class Lift : Hashable, Identifiable, ObservableObject {
    var id: String {
        get {
            return self.liftName
        }
    }
    
    @Published private(set) var liftName: String
    @Published private(set) var trainingMax: Int
    
    init(liftName: String, trainingMax: Int) {
        self.liftName = liftName
        self.trainingMax = trainingMax
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.liftName)
    }
    
    static func == (lhs: Lift, rhs: Lift) -> Bool {
        return lhs.liftName == rhs.liftName
    }
    
    
}
