//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftCatalogView: View {
    @ObservedObject var liftCatalog: LiftCatalog
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($liftCatalog.lifts) {$lift in
                        NavigationLink(lift.name, destination: LiftView(lift: $lift))
                    }
                    .onDelete { indexSet in
                        liftCatalog.lifts.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("Lift Catalog")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("add", action: addStuff)
                }
            }
        }
    }
    
    func addStuff() {
        liftCatalog.lifts.append(Lift(name: "new lift", trainingMax: 0))
    }
}

struct LiftCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        let liftCatalog = LiftCatalog()
        let squatLift = Lift(name: "squat", trainingMax: 315)
        let deadLift = Lift(name: "dead", trainingMax: 405)
        let benchLift = Lift(name: "bench", trainingMax: 250)
        
        liftCatalog.lifts.append(squatLift)
        liftCatalog.lifts.append(deadLift)
        liftCatalog.lifts.append(benchLift)
        
        return LiftCatalogView(liftCatalog: liftCatalog)
    }
}
