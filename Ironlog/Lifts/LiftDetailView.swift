//
//  LiftDetailView.swift
//  Ironlog
//
//  Created by Brian Stauff on 8/27/22.
//

import SwiftUI

struct LiftDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var lift: Lift
    
    @State private var isPresentingEditSheet = false
    @State private var didSaveThrowError = false
    
    var body: some View {
        VStack {
            Text("Training Max").font(.headline)
            Text(String(lift.trainingMax))
            Spacer()
        }
        .navigationTitle(lift.name ?? "unknown")
        .toolbar {
            Button("edit") {
                isPresentingEditSheet = true
            }
        }
        .sheet(isPresented: $isPresentingEditSheet) {
            EditLiftView(liftModel: lift, onLiftUpdated: saveLift)
        }
        .alert("Woops", isPresented: $didSaveThrowError) {
            VStack {
                Text("Failed to save lift")
                Button("OK", role: .cancel){}
            }
        }
    }
    
    func saveLift(updatedName: String, updatedMax: Int) -> Void {
        self.isPresentingEditSheet = false
        
        lift.name = updatedName
        lift.trainingMax = Int32(updatedMax)
        
        do {
            try viewContext.save()
        } catch {
            self.didSaveThrowError = true
        }
    }
}

struct LiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        
        let liftModel = Lift(context: previewContext)
        
        liftModel.name = "Squat"
        liftModel.trainingMax = 315
        
        try! previewContext.save()
        
        return NavigationView {
            LiftDetailView(lift: liftModel)
        }
    }
}
