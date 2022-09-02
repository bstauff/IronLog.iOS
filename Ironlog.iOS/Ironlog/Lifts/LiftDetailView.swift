//
//  LiftDetailView.swift
//  Ironlog
//
//  Created by Brian Stauff on 8/27/22.
//

import SwiftUI

struct LiftDetailView: View {
    @Binding var lift: Lift
    private var liftRepository: LiftRepository
    @State private var isPresentingEditSheet = false
    @State private var didSaveThrowError = false
    
    init(lift: Binding<Lift>, liftRepository: LiftRepository) {
        self._lift = lift
        self.liftRepository = liftRepository
    }
    
    var body: some View {
        VStack {
            Text("Training Max").font(.headline)
            Text(String(lift.trainingMax))
            Spacer()
        }
        .navigationTitle(lift.name)
        .toolbar {
            Button("edit") {
                isPresentingEditSheet = true
            }
        }
        .sheet(isPresented: $isPresentingEditSheet, onDismiss: saveLift) {
            NavigationView {
                EditLiftView(lift: $lift, liftRepository: self.liftRepository)
                .navigationTitle(lift.name)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingEditSheet = false
                        }
                    }
                }
            }
        }
        .alert("Woops", isPresented: $didSaveThrowError) {
            VStack {
                Text("Failed to save lift")
                Button("OK", role: .cancel){}
            }
        }
    }
    
    private func saveLift() {
        do {
            try self.liftRepository.saveLift(lift: lift)
        } catch {
            didSaveThrowError = true
        }
    }
}

struct LiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = Lift(name: "squat", trainingMax: 350)
        let liftRepo = CoreDataLiftRepository()
        NavigationView {
            LiftDetailView(lift: .constant(liftModel), liftRepository: liftRepo)
        }
    }
}

enum MyError : Error {
    case boom
}
