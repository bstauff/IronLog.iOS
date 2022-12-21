//
//  LiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct EditLiftView: View {
    @State private var isError = false
    @State private var errorString = ""
    
    @State private var updatedLiftName: String = ""
    @State private var updatedTrainingMax: Int = 0
    
    let onLiftUpdated: (_ updatedName: String, _ updatedTrainingMax: Int) -> Void
    
    @ObservedObject var lift: LiftModel
    
    init(liftModel: LiftModel, onLiftUpdated: @escaping (String,Int) -> Void) {
        self.lift = liftModel
        self.onLiftUpdated = onLiftUpdated
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Lift Name")
                TextField("Lift Name", text: $updatedLiftName, prompt: Text("lift name"))
                    .textFieldStyle(.roundedBorder)
                Text("Training Max")
                TextField("Training Max", value: $updatedTrainingMax, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                Button("Save", action: saveLift)
            }
            .alert(isPresented: $isError) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorString),
                    dismissButton: .default(Text("OK"))
                )
            }
        }.onAppear {
            self.updatedLiftName = lift.name ?? ""
            self.updatedTrainingMax = Int(lift.trainingMax)
        }
    }
    
    
    func saveLift() {
        guard updatedLiftName != "" else {
            isError = true
            errorString = "lift name is required"
            return
        }
        
        guard updatedTrainingMax > 0 else {
            isError = true
            errorString = "training max is required"
            return
        }
        
        self.onLiftUpdated(updatedLiftName, updatedTrainingMax)
    }
}

struct EditLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = LiftModel(context: PersistenceController.preview.container.viewContext)
        liftModel.name = "Test Lift"
        liftModel.trainingMax = 999
        return EditLiftView(liftModel: liftModel) { updatedName, updatedMax in
            
        }
    }
}
