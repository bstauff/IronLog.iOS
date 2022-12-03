//
//  LiftDetailView.swift
//  Ironlog
//
//  Created by Brian Stauff on 8/27/22.
//

import SwiftUI

struct LiftDetailView: View {
    @Binding var lift: LiftModel
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
//        .sheet(isPresented: $isPresentingEditSheet, onDismiss: saveLift) {
//            NavigationView {
//                EditLiftView(lift: $lift, liftRepository: self.liftRepository)
//                .navigationTitle(lift.name)
//                .toolbar {
//                    ToolbarItem(placement: .cancellationAction) {
//                        Button("Cancel") {
//                            isPresentingEditSheet = false
//                        }
//                    }
//                    ToolbarItem(placement: .confirmationAction) {
//                        Button("Done") {
//                            isPresentingEditSheet = false
//                        }
//                    }
//                }
//            }
//        }
        .alert("Woops", isPresented: $didSaveThrowError) {
            VStack {
                Text("Failed to save lift")
                Button("OK", role: .cancel){}
            }
        }
    }
}

struct LiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        
        let liftModel = LiftModel(context: previewContext)
        
        liftModel.name = "Squat"
        liftModel.trainingMax = 315
        
        try! previewContext.save()
        
        return NavigationView {
            LiftDetailView(lift: .constant(liftModel))
        }
    }
}
