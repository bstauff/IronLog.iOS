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
            ActiveWorkoutView(activeWorkout: Workout(mainMovement: <#T##Movement#>, supplementalMovement: <#T##Movement#>, assistanceMovements: <#T##[Movement]#>))
        }
    }
}
