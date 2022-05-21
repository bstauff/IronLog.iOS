//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftCatalogView: View {
    @State private var isShowingAddSheet = false
    
    @State private var isError = false
    @State private var errorString = ""
    
    @StateObject private var liftCatalog: LiftCatalog = LiftCatalog()
    
    var liftRepo: LiftRepository
    
    init(liftRepo: LiftRepository) {
        self.liftRepo = liftRepo
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(liftCatalog.lifts) {lift in
                        NavigationLink(lift.name, destination: EditLiftView(lift: lift, liftRepository: liftRepo))
                    }
                    .onDelete(perform: deleteLifts)
                    .alert(isPresented: $isError) {
                        Alert(
                            title: Text("Error"),
                            message: Text(errorString),
                            dismissButton: .default(Text("OK"))
                        )
                    }
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
                        AddLiftView(liftRepo: liftRepo, liftCatalog: liftCatalog)
                    }
                }
            }
        }.onAppear(perform: loadLifts)
    }
    
    func loadLifts() {
        do {
            let lifts = try liftRepo.getAllLifts()
            liftCatalog.lifts = lifts
        } catch {
            isError = true
            errorString = "Failed to load lifts"
        }
    }
    
    func deleteLifts(offsets: IndexSet) {
        do {
            for offset in offsets {
                let liftToDelete = liftCatalog.lifts[offset]
                
                try liftRepo.deleteLift(liftId: liftToDelete.id)
            }
            
            liftCatalog.lifts.remove(atOffsets: offsets)
        } catch {
            isError = true
            errorString = "Failed to delete.  Please try again."
        }
    }
}

struct LiftCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataLiftRepository()
        let squat = Lift(name: "Squat", trainingMax: 315)
        try? liftRepo.addLift(lift: squat)
        return LiftCatalogView(liftRepo: liftRepo)
    }
}
