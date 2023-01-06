//
//  ActiveMainView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/31/22.
//

import SwiftUI

struct ActiveMainView: View {
    
    @Binding var path: NavigationPath
    
    @ObservedObject var workout: Workout
    
    var body: some View {
        Text("Active main!")
        Spacer()
        Button("Complete") { }
    }
}

struct ActiveMainView_Previews: PreviewProvider {
    static var previews: some View {
        let path = NavigationPath()
        
        let viewContext = PersistenceController.preview.container.viewContext
        let workout = try! viewContext.fetch(Workout.fetchRequest()).first!
        
        NavigationStack(path: .constant(path)) {
            ActiveMainView(path: .constant(path), workout: workout)
        }
    }
}
