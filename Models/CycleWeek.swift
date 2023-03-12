//
//  WorkoutWeeks.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/25/23.
//

import Foundation

enum CycleWeek: CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .firstWeek:
            return "First week"
        case .secondWeek:
            return "Second week"
        case .thirdWeek:
            return "Third Week"
        }
    }
    
    case firstWeek
    case secondWeek
    case thirdWeek
}
