//
//  ActiveWorkoutExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct ExerciseCompletionRowView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var exerciseSet: ExerciseSetModel
    
    @State var errorMessage: String = ""
    @State var isError: Bool = false
    
    var body: some View {
        HStack {
            Toggle(isOn: $exerciseSet.isComplete) {
                Text("done")
            }
            .onChange(of: exerciseSet.isComplete) { complete in
                do {
                    try viewContext.save()
                } catch {
                    self.isError = true
                    self.errorMessage = "failed to update set status"
                }
            }
            .toggleStyle(.button)
            Spacer()
            Text(String(exerciseSet.reps))
            Spacer()
            Text(String(exerciseSet.weight))
        }
        .alert(isPresented: $isError, content: {
            Alert(title: Text("Oops"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
        })
        
            
        
    }
}

struct ExerciseCompletionRowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let exercise = try? viewContext.fetch(ExerciseModel.fetchRequest()).first
        return ExerciseCompletionRowView(exerciseSet: exercise!.exerciseSets?.firstObject! as! ExerciseSetModel)
    }
}
