//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\FslAmrapWorkout.date)]) var workouts: FetchedResults<FslAmrapWorkout>
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(workouts){ workout in
                NavigationLink(destination: ActiveFslAmrapView(workout: workout)) {
                    Text(getWorkoutDate(workout: workout))
                }
            }
            .navigationTitle(Text("Choose a workout"))
        }
//        .alert(isPresented: $isError) {
//            Alert(
//                title: Text("oops"),
//                message: Text("Failed to save workout"),
//                dismissButton: .default(Text("OK")))
//        }
    }
    
    func getWorkoutDate(workout: Workout) -> String{
        guard workout.date != nil else  {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout.date!)
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        ActiveWorkoutView()
            .environment(\.managedObjectContext, viewContext)
    }
}
