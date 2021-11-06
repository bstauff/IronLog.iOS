//
//  IronlogApp.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI

@main
struct IronlogApp: App {
    var body: some Scene {
        WindowGroup {
            let mockWorkout = MockDataWorkoutService().getWorkouts()
            ActiveWorkoutView(activeWorkout: mockWorkout)
        }
    }
}
