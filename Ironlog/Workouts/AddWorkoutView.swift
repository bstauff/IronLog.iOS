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
    @State private var selectedLift: Lift? = nil
    
    @State private var isError = false
    @State private var errorString = ""
    @State private var selectedCycleWeek: CycleWeek = CycleWeek.firstWeek
    
    private var newWorkout: FslAmrapWorkout
    
    init() {
        newWorkout = FslAmrapWorkout()
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    DatePicker("Workout Date", selection: $selectedDate, displayedComponents: .date)
                }
                Section {
                    Picker("Cycle Week", selection: $selectedCycleWeek) {
                        ForEach(CycleWeek.allCases, id: \.self) { week in
                            Text(week.description)
                                .tag(week)
                        }
                    }
                }
                Section {
                    Picker("Main Lift", selection: $selectedLift) {
                        Text("Select Lift").tag(Optional<Lift>(nil))
                        ForEach(lifts) { lift in
                            Text(lift.name ?? "").tag(lift as Lift?)
                        }
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Create") {
                            saveClicked()
                        }
                        .buttonStyle(.borderedProminent)
                        .alert(isPresented: $isError) {
                            Alert(title: Text("Error"), message: Text(errorString), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                }
            }.navigationTitle("Add Workout")
        }
    }
    
    func saveClicked() {
        guard let selectedLift = self.selectedLift else {
            isError = true
            errorString = "You must select a main lift"
            return
        }
        
        let newWorkout =
            FslAmrapWorkout(
                entity: FslAmrapWorkout.entity(),
                insertInto: viewContext)
        newWorkout.id = UUID()
        newWorkout.date = selectedDate.timeIntervalSince1970
        newWorkout.isComplete = false
        
        newWorkout.planForWeek(
            lift: selectedLift,
            week: self.selectedCycleWeek)
        
        do {
            try viewContext.save()
        } catch {
            isError = true
            errorString = error.localizedDescription
//            errorString = "Failed to add new workout"
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
