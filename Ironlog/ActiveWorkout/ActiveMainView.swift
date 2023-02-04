//
//  ActiveMainView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/10/23.
//

import SwiftUI
import Foundation

struct ActiveMainView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: FslAmrapWorkout
    
    @StateObject var restTimer = WorkoutTimer(secondsForCountDown: 120)
    
    @State
    var repsCompleted: Int? = nil
    
    @State
    var isError = false
    
    @State
    var errorMessage = ""
    
    var onComplete: () -> Void
    
    var body: some View {
        List {
            Section {
                ExerciseCompletionView(exercise: workout.mainExercise!)
            }
            Section("AMRAP Reps Completed") {
                TextField("AMRAP", value: $repsCompleted, format: .number, prompt: Text("Enter reps completed"))
                    .keyboardType(.numberPad)
            }
            Section {
                HStack {
                    Spacer()
                    Button("Complete") {
                        self.workout.recordReps = Int32(repsCompleted ?? 0)
                        saveWorkout()
                        self.onComplete()
                    }
                    Spacer()
                }
            }
            Section ("rest") {
                VStack {
                    if self.restTimer.timerRunning {
                        Text("Resting " + String(self.restTimer.secondsRemaining) + " seconds")
                    } else {
                        Button("Rest"){
                            self.restTimer.startTimer()
                        }
                    }
                }
            }
        }
        .alert("Oops", isPresented: $isError) {
            Button("OK") { }
        } message: {
            Text(self.errorMessage)
        }
        .navigationTitle("Main")
    }
    
    func saveWorkout() {
        do {
            try viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "Failed to save workout"
        }
    }
}

struct ActiveMainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workout = try! viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        ActiveMainView(workout: workout) { }
    }
}
