//
//  ActiveWarmupView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/7/23.
//

import SwiftUI

struct ActiveWarmupView: View {
    @ObservedObject var warmupExercise: WarmupExercise
    
    var body: some View {
        Text("Active warmup!")
    }
}

struct ActiveWarmupView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let warmupExercise = try! viewContext.fetch(WarmupExercise.fetchRequest()).first as! WarmupExercise
        ActiveWarmupView(warmupExercise: warmupExercise)
    }
}
