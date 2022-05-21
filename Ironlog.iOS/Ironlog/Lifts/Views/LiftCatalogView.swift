//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftCatalogView: View {
    @FetchRequest(sortDescriptors: []) var lifts: FetchedResults<LiftModel>
    @Environment(\.managedObjectContext) var moc
    @State private var isShowingAddSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(lifts) {lift in
                        NavigationLink(lift.name!, destination: EditLiftView(lift: lift))
                    }
                    .onDelete(perform: deleteLifts)
                }
            }
            .navigationTitle("Lift Catalog")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("add"){
                        isShowingAddSheet = true
                    }.sheet(isPresented: $isShowingAddSheet){
                        AddLiftSheetView()
                    }
                }
            }
        }
    }
    
    func deleteLifts(offsets: IndexSet) {
        for offset in offsets {
            let lift = lifts[offset]
            
            moc.delete(lift)
        }
        
        try? moc.save()
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
        
        return LiftCatalogView()
    }
}
