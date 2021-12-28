//
//  AddCycleWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddCycleWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var cycle: Cycle
    @State private var selectedDate = Date()
    @State private var isError = false
    @State private var errorString = ""
    
    var body: some View {
        VStack {
            Text("Add Workout")
                .font(.largeTitle)
            DatePicker("Workout Date", selection: $selectedDate, displayedComponents: .date)
            Button("Save") {
                saveClicked()
            }
            .alert(isPresented: $isError) {
                Alert(title: Text("Error"), message: Text(errorString), dismissButton: .default(Text("OK")))
            }
            .buttonStyle(.borderedProminent)
        }
    }
    func saveClicked() {
        if cycle.doesCycleHaveWorkoutForDate(date: selectedDate) {
            isError = true
            errorString = "This date already has a workout"
            return
        }
        let newWorkout = Workout(date: selectedDate)
        cycle.workouts.append(newWorkout)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddCycleWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let cycle = Cycle()
        AddCycleWorkoutView(cycle: cycle)
    }
}
