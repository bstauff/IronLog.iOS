//
//  WorkoutCompletionView.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/6/22.
//

import SwiftUI
import CoreData

struct WorkoutCompletionView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: FslAmrapWorkout
    
    @State private var errorMessage = ""
    @State private var isError = false
    
    var body: some View {
        VStack {
            ForEach(getExercises()) { exercise in
                ExerciseCompletionView(exercise: exercise)
            }
            VStack {
                Text("AMRAP Record Reps")
                HStack {
                    Spacer()
                    TextField("apples", value: $workout.recordReps, format: .number, prompt: Text("record reps"))
                        .frame(width: 200)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
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
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: workout.date))
    }
    
    private func getExercises() -> [Exercise] {
        let exercises = self.workout.warmupExercises?.array as? [Exercise]
        return exercises ?? []
    }
}

struct WorkoutCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let fetchRequest: NSFetchRequest<FslAmrapWorkout> = FslAmrapWorkout.fetchRequest()
        let workout = try! viewContext.fetch(fetchRequest).first!
        return
            NavigationView {
                WorkoutCompletionView(workout: workout)
            }
                .environment(\.managedObjectContext, viewContext)
    }
}
