//
//  AddLiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/25/22.
//

import SwiftUI

struct AddLiftView: View {
    @Environment(\.presentationMode) var presentationMode
    private var repo: LiftRepository
    
    @State private var isError = false
    @State private var errorString = ""
    
    @State var liftName: String?
    @State var trainingMax: Int?
        
    @ObservedObject var liftCatalog: LiftCatalog
    
    init(liftRepo: LiftRepository, liftCatalog: LiftCatalog) {
        self.liftCatalog = liftCatalog
        self.repo = liftRepo
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(
                    "Lift Name")
                TextField(
                    "Lift Name",
                    text: $liftName.toUnwrapped(defaultValue: "")
                )
                Text("Training Max")
                TextField(
                    "Training Max",
                    value: $trainingMax,
                    format: .number
                ).keyboardType(.numberPad)
                Button("Save") {
                    saveClicked()
                }
                .buttonStyle(.borderedProminent)
                .alert(isPresented: $isError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorString),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    private func saveClicked() {
        guard liftName != nil else {
            isError = true
            errorString = "lift name required"
            return
        }
        
        guard trainingMax != nil else {
            isError = true
            errorString = "training max required"
            return
        }
        
        let newLift = Lift(name: liftName!, trainingMax: trainingMax!)
            
        do {
            try repo.addLift(lift: newLift)
        }catch {
            isError = true
            errorString = "failed to save lift"
        }
            
        liftCatalog.lifts.append(newLift)
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataLiftRepository()
        let liftCatalog = LiftCatalog()
        AddLiftView(liftRepo: liftRepo, liftCatalog: liftCatalog)
    }
}
