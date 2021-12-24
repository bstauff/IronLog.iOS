//
//  LiftCatalogView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import SwiftUI

struct LiftCatalogView: View {
    
    @EnvironmentObject var liftCatalog: LiftCatalog
    
    var body: some View {
        NavigationView {
            List {
                ForEach($liftCatalog.lifts, id: \.self) { lift in
                    NavigationLink(destination: LiftDetailView(liftToEdit:lift)) {
                        Text(lift.liftName)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Lift Catalog")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    addButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    var addButton: some View {
        Button("Add") {
            liftCatalog.addLift(liftToAdd: Lift(liftName: "New Lift", trainingMax: 0))
        }
    }
    
    private func delete(indexSet: IndexSet) {
        liftCatalog.deleteIndexes(indexes: indexSet)
    }
}

struct LiftCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        LiftCatalogView().environmentObject(MockLiftService().getLiftCatalog())
    }
}
