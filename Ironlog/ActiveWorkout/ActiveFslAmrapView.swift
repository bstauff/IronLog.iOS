//
//  ActiveFslAmrapView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/7/23.
//

import SwiftUI

struct ActiveFslAmrapView: View {
    @ObservedObject var workout: FslAmrapWorkout
    @State var path: NavigationPath = NavigationPath()
    private var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
        
    
    var body: some View {
        VStack {
            NavigationStack(path: $path) {
                VStack{
                    Text("When you're ready to start your workout, click begin!")
                    Button("BEGIN"){
                        path.append(warmupExercises)
                    }
                        .buttonStyle(.borderedProminent)
                }
                .navigationDestination(for: Array<WarmupExercise>.self) { warmups in
                    ActiveWarmupView(workout: workout)
                }
            }
        }
        .navigationTitle("FSL Amrap Workout")
    }
}

struct ActiveFslAmrapView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        let path = NavigationPath()
        NavigationStack {
            ActiveFslAmrapView(workout: workout)
        }
    }
}
