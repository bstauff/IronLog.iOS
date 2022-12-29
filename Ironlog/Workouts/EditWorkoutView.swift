//
//  EditWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/22/22.
//

import SwiftUI
import CoreData

struct EditWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var workout: FslAmrapWorkout
    
    @State private var selectedDate: Date = Date()
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Edit Workout")
                .font(.largeTitle)
            DatePicker("Workout Date", selection: $selectedDate, displayedComponents: .date)
            Button("Save", action: saveClicked)
            .alert(isPresented: $isError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            self.selectedDate = workout.date ?? Date()
        }
    }
    
    private func saveClicked() -> Void {
        do {
            workout.date = self.selectedDate
            try self.viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "faild to save workout"
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let fetchRequest: NSFetchRequest<FslAmrapWorkout> = FslAmrapWorkout.fetchRequest()
        let workoutModel = try! viewContext.fetch(fetchRequest).first!
        EditWorkoutView(workout: workoutModel)
            .environment(\.managedObjectContext, viewContext)
    }
}
