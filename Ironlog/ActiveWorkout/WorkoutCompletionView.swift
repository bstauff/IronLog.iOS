//
//  WorkoutCompletionView.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/6/22.
//

import SwiftUI

struct WorkoutCompletionView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: WorkoutModel
    
    var body: some View {
        VStack {
            ForEach(getExercises()) { exercise in
                ExerciseCompletionView(exercise: exercise)
            }
            HStack {
                Spacer()
                Toggle(isOn: $workout.isComplete) {
                    Text("Workout Complete")
                }
                    .toggleStyle(.button)
                    .onChange(of: workout.isComplete) { value in
                    }
                Spacer()
            }
        }
    }
    
    private func getExercises() -> [ExerciseModel] {
        let exercises = self.workout.workoutExercises?.array as? [ExerciseModel]
        return exercises ?? []
    }
}

struct WorkoutCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workout = try! viewContext.fetch(WorkoutModel.fetchRequest()).first!
        return WorkoutCompletionView(workout: workout)
            .environment(\.managedObjectContext, viewContext)
    }
}
