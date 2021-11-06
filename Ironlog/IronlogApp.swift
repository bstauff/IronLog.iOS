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
            ContentView(
                workout: Workout(
                    mainSets: [], supplementalSets: [], assistanceSets: []
                )
            )
        }
    }
}
