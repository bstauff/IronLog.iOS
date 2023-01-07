//
//  ActiveFslAmrapView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/7/23.
//

import SwiftUI

struct ActiveFslAmrapView: View {
    @Binding var path: NavigationPath
    @ObservedObject var workout: FslAmrapWorkout
    
    private var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
        
    
    var body: some View {
        VStack {
            Text("FSL Amrap Workout")
                .font(.largeTitle)
            Text("Hit begin to start your workout!")
            Spacer()
            Button("Begin") {
                path.append(warmupExercises.first!)
            }
                .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}

struct ActiveFslAmrapView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        let path = NavigationPath()
        NavigationStack(path: .constant(path)) {
            ActiveFslAmrapView(path: .constant(path), workout: workout)
        }
    }
}
