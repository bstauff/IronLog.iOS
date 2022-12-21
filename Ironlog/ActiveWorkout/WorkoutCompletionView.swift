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
    
    @State private var errorMessage = ""
    @State private var isError = false
    
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
                        do {
                            try self.viewContext.save()
                        } catch {
                            self.isError = true
                            self.errorMessage = "failed to save workout"
                        }
                    }
                Spacer()
            }
        }
        .navigationTitle(Text(getFormattedDate()))
        .alert(
            "Oops",
            isPresented: $isError,
            presenting: self.workout,
            actions: {workout in Button("OK"){}}) { workout in
                Text(errorMessage)
        }
    }
    
    private func getFormattedDate() -> String {
        guard self.workout.date != nil else {
           return ""
        }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        
        return dateFormatter.string(from: self.workout.date!)
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
        return
            NavigationView {
                WorkoutCompletionView(workout: workout)
            }
                .environment(\.managedObjectContext, viewContext)
    }
}
