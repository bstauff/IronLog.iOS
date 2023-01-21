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
    
    @State
    var repsCompleted: Int? = nil
    
    @State
    var isError = false
    @State
    var errorMessage = ""
    @State
    var elapsed = 0.0
    
    var onComplete: () -> Void
        
    let timer: Timer? = nil
    
    @State
    var restEndTime: Date? = nil
    
    @State
    var remainingRest: Int = 0
    
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
                    if restEndTime != nil {
                        Text("Rest remaining \(remainingRest)")
                    }
                    Button("Rest"){
                        self.restEndTime = Calendar.current.date(byAdding: .minute, value: 5, to: Date())
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ timer in
                            if self.restEndTime != nil && Date() >= self.restEndTime! {
                                timer.invalidate()
                                self.restEndTime = nil
                            }
                            let stuff = Calendar.current.dateComponents([.second], from: Date(), to: restEndTime!).second ?? 0
                            self.remainingRest = stuff
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
