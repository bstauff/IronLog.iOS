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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<Lift>
    
    @State private var selectedDate = Date()
    @State private var selectedLift: Lift?
    
    @State private var isError = false
    @State private var errorString = ""
    @State private var selectedCycleWeek = 1
    
    var body: some View {
        VStack {
            Text("Add Workout")
                .font(.largeTitle)
            HStack {
                Spacer()
                DatePicker("Workout Date", selection: $selectedDate, displayedComponents: .date)
                Spacer()
            }
            HStack {
                Spacer()
                Text("Main lift")
                Spacer()
                Picker("Lift", selection: $selectedLift) {
                    ForEach(lifts) { lift in
                        Text(lift.name ?? "").tag(lift as Lift?)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                Text("Cycle week")
                Spacer()
            }
            Picker("Cycle Week", selection: $selectedCycleWeek) {
                ForEach((1..<4)) { week in
                    Text(String(week)).tag(week)
                }
            }.pickerStyle(.segmented)
            Button("Create") {
                saveClicked()
            }
            .alert(isPresented: $isError) {
                Alert(title: Text("Error"), message: Text(errorString), dismissButton: .default(Text("OK")))
            }
            .buttonStyle(.borderedProminent)
        }
    }
    func saveClicked() {
        let newWorkout = FslAmrapWorkout(context: viewContext)
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
