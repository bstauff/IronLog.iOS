//
//  AddSetView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/22.
//

import SwiftUI

struct AddSetView: View {
    
    let onCreateSet: (_ exerciseSet: ExerciseSet) -> Void
    
    @State var newReps: Int?
    @State var newWeight: Int?
    
    @State var isError = false
    @State var errorMessage = ""
    
    var body: some View {
        HStack {
            Spacer()
            TextField("Reps", value: $newReps, format: .number, prompt: Text("Reps"))
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            Spacer()
            TextField("Weight", value: $newWeight, format: .number, prompt: Text("Weight"))
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            Spacer()
            Button(action: {
                withAnimation{
                    createNewSet()
                }
            }) {
                Image(systemName: "plus.circle.fill")
            }
                .disabled(areNewInputsInvalid())
                .alert("Oops", isPresented: $isError) {
                    Button("Ok"){
                        isError = false
                        errorMessage = ""
                    }
                } message: {
                    Text(errorMessage)
                }
            Spacer()
        }
    }
    
    func createNewSet() -> Void {
        guard !areNewInputsInvalid() else {
            self.isError = true
            self.errorMessage = "Reps and Sets must have a value"
            return
        }
        
        let newSet = ExerciseSet(reps: self.newReps!, weight: self.newWeight!)
        
        self.newReps = nil
        self.newWeight = nil
        
        self.onCreateSet(newSet)
    }
    
    private func areNewInputsInvalid() -> Bool {
        return
            self.newReps == nil ||
            self.newWeight == nil
    }
}

struct AddSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSetView{ exerciseSet in
        }
    }
}
