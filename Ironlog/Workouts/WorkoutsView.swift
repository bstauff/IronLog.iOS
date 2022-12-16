//
//  CycleView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\WorkoutModel.date)]) var workouts: FetchedResults<WorkoutModel>
    
    @State private var isShowingWorkoutSheet = false
    @State private var isError = false
    @State private var errorString = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(workouts){ workout in
                        NavigationLink(
                            getWorkoutDate(workout: workout),
                            destination:
                                WorkoutDetailsView(workout: workout))
                    }
                    .onDelete(perform: deleteWorkouts)
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("add") {
                        self.isShowingWorkoutSheet = true
                    }.sheet(isPresented: $isShowingWorkoutSheet) {
                        AddWorkoutView()
                    }
                }
            }
        }
    }
    func getWorkoutDate(workout: WorkoutModel?) -> String{
        guard workout?.date != nil else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout!.date!)
    }
    func deleteWorkouts(offsets: IndexSet) {
        do {
            for offset in offsets {
                let workoutToDelete = self.workouts[offset]
                self.viewContext.delete(workoutToDelete)
            }
            try self.viewContext.save()
        } catch {
            isError = true
            errorString = "Failed to delete.  Please try again."
        }
    }
}


struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        WorkoutsView()
            .environment(\.managedObjectContext, viewContext)
    }
}
