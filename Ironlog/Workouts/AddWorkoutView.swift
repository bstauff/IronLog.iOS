//
//  AddCycleWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
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
        let newWorkout = Workout(context: viewContext)
        newWorkout.id = UUID()
        newWorkout.isComplete = false
        newWorkout.date = selectedDate
        
        do {
            try viewContext.save()
        } catch {
            isError = true
            errorString = "Failed to add new workout"
            return
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        AddWorkoutView()
            .environment(\.managedObjectContext, viewContext)
    }
}
