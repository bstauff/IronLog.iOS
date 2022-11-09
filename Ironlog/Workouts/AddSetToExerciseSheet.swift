//
//  ExerciseAddSetView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddSetToExerciseSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var exerciseSets: [ExerciseSet]
    @State private var reps: Int? = nil
    @State private var weight: Int? = nil
    
    @State private var isError = false
    @State private var errorMessage = ""
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing:20) {
                Spacer()
                VStack {
                    Text("Reps")
                    TextField("Reps", value: $reps, format: .number)
                }
                Spacer()
            }
            HStack(spacing:20) {
                Spacer()
                VStack {
                    Text("Weight")
                    TextField("Weight", value: $weight, format: .number)
                }
                Spacer()
            }
            Button("add") {
                guard reps != nil || weight != nil else {
                    isError = true
                    errorMessage = "Both weight and reps are required"
                    return
                }
                
                let exerciseSet = ExerciseSet(reps: self.reps!, weight: self.weight!)
                
                exerciseSets.append(exerciseSet)
                
                presentationMode.wrappedValue.dismiss()
            }.alert(isPresented: $isError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }.buttonStyle(.borderedProminent)
        }
        
    }
}

struct AddSetToExerciseSheet_Previews: PreviewProvider {
    static var previews: some View {
        let exerciseSets: [ExerciseSet] = []
        AddSetToExerciseSheet(exerciseSets: .constant(exerciseSets))
    }
}
