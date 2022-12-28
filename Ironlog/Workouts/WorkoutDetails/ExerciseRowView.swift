//
//  ExerciseRowView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI

struct ExerciseRowView: View {
    @ObservedObject var exercise: Exercise
    var body: some View {
        Text(exercise.lift?.name ?? "")
    }
}

struct ExerciseRowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let exerciseRequest = Exercise.fetchRequest()

        let exercise = try! viewContext.fetch(exerciseRequest).first!

        ExerciseRowView(exercise: exercise)
    }
}
