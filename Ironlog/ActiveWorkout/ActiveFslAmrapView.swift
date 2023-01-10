//
//  ActiveFslAmrapView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/7/23.
//

import SwiftUI

struct ActiveFslAmrapView: View {
    @ObservedObject var workout: FslAmrapWorkout
    
    @Binding var navigationPath: NavigationPath
    
    private var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack{
                Text("When you're ready to start your workout, click begin!")
                Button("BEGIN"){
                    self.navigationPath.append(warmupExercises)
                }
                    .buttonStyle(.borderedProminent)
            }
        }
        .navigationDestination(for: Array<WarmupExercise>.self) { warmups in
            ActiveWarmupView(workout: workout) {
                self.navigationPath.append(self.workout.mainExercise!)
            }
        }
        .navigationDestination(for: MainExercise.self) { mainExercise in
            ActiveMainView()
        }
    }
}

struct ActiveFslAmrapView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        let path = NavigationPath()
        NavigationStack(path: .constant(path)) {
            ActiveFslAmrapView(workout: workout, navigationPath: .constant(path))
        }
    }
}
