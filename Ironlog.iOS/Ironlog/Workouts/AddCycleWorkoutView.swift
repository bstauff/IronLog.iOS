//
//  AddCycleWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding private var workouts: [Workout]
    @State private var selectedDate = Date()
    @State private var isError = false
    @State private var errorString = ""
    
    private var repo: AppRepository
    
    init(repo: AppRepository, workouts: Binding<[Workout]>) {
        self.repo = repo
        self._workouts = workouts
    }
    
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
        let newWorkout = Workout(date: selectedDate)
        
        do {
            try repo.saveWorkout(workout: newWorkout)
        } catch {
            isError = true
            errorString = "Failed to add new workout"
            return
        }
        self.workouts.append(newWorkout)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddCycleWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workouts: [Workout] = []
        let appRepo = CoreDataRepository()
        AddWorkoutView(repo: appRepo, workouts: .constant(workouts))
    }
}
