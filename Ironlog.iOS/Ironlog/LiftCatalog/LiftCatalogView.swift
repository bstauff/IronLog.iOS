//
//  LiftCatalogView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import SwiftUI

struct LiftCatalogView: View {
    
    @EnvironmentObject var liftCatalog: LiftCatalog
   
    @State private var selectedLift : Lift?
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(liftCatalog.lifts) { lift in
                        NavigationLink {
                            LiftDetailView(lift: lift)
                        } label: {
                            Text(lift.liftName)
                        }
                    }
                    .onDelete(perform: {self.liftCatalog.deleteIndexes(indexes: $0)})
                }
                .navigationTitle("Lifts")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {print("bananas")}) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct LiftCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        LiftCatalogView().environmentObject(MockLiftService().getLiftCatalog())
    }
}
