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
    
    @State
    var isWorkoutComplete = false
    
    private var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
    
    private var assistanceExercises: [AssistanceExercise] {
        return workout.assistanceExercises?.array as? [AssistanceExercise] ?? []
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
            .navigationTitle("FSL AMRAP Workout")
        }
        .navigationDestination(for: Array<WarmupExercise>.self) { warmups in
            ActiveWarmupView(workout: workout) {
                self.navigationPath.append(self.workout.mainExercise!)
            }
        }
        .navigationDestination(for: MainExercise.self) { mainExercise in
            ActiveMainView(workout: self.workout) {
                self.navigationPath.append(self.workout.supplementalExercise!)
            }
        }
        .navigationDestination(for: SupplementalExercise.self) { supplementalExercise in
            ActiveSupplementalView(supplementalExercise: supplementalExercise) {
                self.navigationPath.append(assistanceExercises)
            }
        }
        .navigationDestination(for: Array<AssistanceExercise>.self){ assistance in
            ActiveAssistanceView(workout: self.workout){
                self.workout.isComplete = true
                
                self.isWorkoutComplete = true
            }
        }
        .alert("Workout Complete", isPresented: $isWorkoutComplete) {
            Button("OK") {
                self.navigationPath.removeLast(self.navigationPath.count)
            }
        } message: {
            Text("Congratulations!  You completed an FSL AMRAP workout!")
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
