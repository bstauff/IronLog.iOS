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
        .sheet(isPresented: $isPresentingEditSheet) {
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
