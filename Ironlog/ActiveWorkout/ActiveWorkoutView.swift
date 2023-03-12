//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @FetchRequest(sortDescriptors:[SortDescriptor(\FslAmrapWorkout.date)]) var workouts: FetchedResults<FslAmrapWorkout>
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(workouts){ workout in
                NavigationLink(value: workout) {
                    Text(getWorkoutDate(workout: workout))
                }
            }
            .navigationTitle(Text("Choose a workout"))
            .navigationDestination(for: FslAmrapWorkout.self) { workout in
                ActiveFslAmrapView(workout: workout, navigationPath: $path)
            }
        }
    }
    
    func getWorkoutDate(workout: Workout) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: Date(timeIntervalSince1970: workout.date))
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        ActiveWorkoutView()
            .environment(\.managedObjectContext, viewContext)
    }
}
