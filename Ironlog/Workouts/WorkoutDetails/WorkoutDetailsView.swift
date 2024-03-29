//
//  WorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI
import CoreData

struct WorkoutDetailsView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: FslAmrapWorkout
    
    @State private var isShowingEditSheet = false
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        VStack {
            List {
                WarmUpView(workout: self.workout)
                MainView(workout: self.workout)
                SupplementalView(workout: self.workout)
                AssistanceView(workout: self.workout)
                Section("AMRAP Record Reps") {
                    Text("\(workout.recordReps)")
                }
            }
            .listStyle(.insetGrouped)
        }
        .sheet(isPresented: $isShowingEditSheet) {
            EditWorkoutView(workout: workout)
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("Error"),
                message: Text(self.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle(Text(convertDateToString()))
        .toolbar {
            ToolbarItem(placement:.navigationBarTrailing) {
                Button("Edit") {
                    self.isShowingEditSheet = true
                }
            }
        }
    }
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self.workout.date))
    }
    
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<FslAmrapWorkout> = FslAmrapWorkout.fetchRequest()

        let moreStuff = try? viewContext.fetch(fetchRequest)

        return NavigationView {
            WorkoutDetailsView(workout: (moreStuff?.first!)!)
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
