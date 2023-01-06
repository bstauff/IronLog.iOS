//
//  ActiveFslAmrapVIew.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/6/23.
//

import SwiftUI

struct ActiveFslAmrapVIew: View {
    @Binding var path: NavigationPath
    @ObservedObject var workout: FslAmrapWorkout
    
    var body: some View {
        
    }
}

struct ActiveFslAmrapVIew_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workout = try! viewContext.fetch(Workout.fetchRequest()).first!
        ActiveFslAmrapVIew()
    }
}
