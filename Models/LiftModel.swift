//
//  LiftModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/25/23.
//

import Foundation

struct LiftModel {
    var name: String
    var trainingMax: Int
    init(name: String, trainingMax: Int) {
        self.name = name
        self.trainingMax = trainingMax
    }
}
