//
//  AddLiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/25/22.
//

import SwiftUI

struct AddLiftView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var isError = false
    @State private var errorString = ""
    
    @State var liftName: String = ""
    @State var trainingMax: Int?
    
    var body: some View {
        HStack {
            VStack {
                Text("Lift Name")
                TextField("Lift Name", text: $liftName, prompt: Text("Lift name"))
                    .textFieldStyle(.roundedBorder)
                Text("Training Max")
                TextField("Training Max", value: $trainingMax, format: .number)
                    .keyboardType(.numberPad)
                Button("Save", action: saveClicked)
                    .buttonStyle(.borderedProminent)
            }
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("Error"),
                message: Text(errorString),
                dismissButton: .default(Text("OK")))
        }
    }
    private func saveClicked() {
        guard liftName != "" else {
            isError = true
            errorString = "lift name required"
            return
        }
        
        guard trainingMax != nil else {
            isError = true
            errorString = "training max required"
            return
        }
        
        let newLift = Lift(context: viewContext)
        newLift.name = liftName
        newLift.trainingMax = Int32(trainingMax!)
        newLift.id = UUID()
            
        do {
            try viewContext.save()
        }catch {
            isError = true
            errorString = "failed to save lift"
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        return AddLiftView().environment(\.managedObjectContext, viewContext)
    }
}
