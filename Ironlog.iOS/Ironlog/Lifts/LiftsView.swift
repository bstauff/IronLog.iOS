//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftsView: View {
    @State private var isShowingAddSheet = false
    
    @State private var isError = false
    @State private var errorString = ""
    
    @State private var lifts: [Lift] = []
    
    var liftRepo: AppRepository
    
    init(liftRepo: AppRepository) {
        self.liftRepo = liftRepo
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($lifts) {$lift in
                        NavigationLink(
                            destination: LiftDetailView(lift: $lift, liftRepository: liftRepo))
                        {
                            LiftLineItemView(lift: lift)
                        }
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
                        AddLiftView(liftRepo: liftRepo, lifts: $lifts)
                    }
                }
            }
        }.onAppear(perform: loadLifts)
    }
    
    func loadLifts() {
        do {
            let lifts = try liftRepo.getAllLifts()
            self.lifts = lifts
        } catch {
            isError = true
            errorString = "Failed to load lifts"
        }
    }
    
    func deleteLifts(offsets: IndexSet) {
        do {
            for offset in offsets {
                let liftToDelete = self.lifts[offset]
                
                try liftRepo.deleteLift(liftId: liftToDelete.id)
            }
            
            self.lifts.remove(atOffsets: offsets)
        } catch {
            isError = true
            errorString = "Failed to delete.  Please try again."
        }
    }
}

struct LiftsView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataRepository()
        let squat = Lift(name: "Squat", trainingMax: 315)
        try? liftRepo.addLift(lift: squat)
        return LiftsView(liftRepo: liftRepo)
    }
}
