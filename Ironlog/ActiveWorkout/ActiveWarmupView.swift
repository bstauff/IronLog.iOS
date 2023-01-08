//
//  ActiveWarmupView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/7/23.
//

import SwiftUI

struct ActiveWarmupView: View {
    @ObservedObject var workout: FslAmrapWorkout
    
    var body: some View {
        Text("Active warmup!")
    }
}

struct ActiveWarmupView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        return ActiveWarmupView(workout: workout)
    }
}
