//
//  ActiveWarmUpView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/31/22.
//

import SwiftUI

struct ActiveWarmUpView: View {
    @Binding var path: NavigationPath
    @ObservedObject var workout: Workout
    
    var body: some View {
        VStack {
            Text("Active Warm up!")
            Spacer()
            Button("Complete") {
                path.append(workout.mainExercise)
            }
        }
    }
}

struct ActiveWarmUpView_Previews: PreviewProvider {
    static var previews: some View {
        let path = NavigationPath()
        
        let viewContext = PersistenceController.preview.container.viewContext
        let workout = try! viewContext.fetch(Workout.fetchRequest()).first!
        
        return NavigationStack(path: .constant(path)) {
            ActiveWarmUpView(path: .constant(path), workout: workout)
        }
    }
}
