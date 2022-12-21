//
//  ExerciseCompletionVIew.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/3/22.
//

import SwiftUI

struct ExerciseCompletionView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var exercise: ExerciseModel
    
    var body: some View {
        VStack {
            Text(exercise.exerciseLift?.name ?? "")
                .font(.headline)
            ForEach(getSets()){ exerciseSet in
                ExerciseCompletionRowView(exerciseSet: exerciseSet)
            }
        }
    }
    
    private func getSets() -> [ExerciseSetModel] {
        let exerciseSets = exercise.exerciseSets?.array as? [ExerciseSetModel]
        
        return exerciseSets ?? []
    }
}

struct ExerciseCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let exercise = try! viewContext.fetch(ExerciseModel.fetchRequest()).first!
        ExerciseCompletionView(exercise: exercise)
            .environment(\.managedObjectContext, viewContext)
    }
}
