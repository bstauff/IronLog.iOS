//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftsView: View {
    @Binding private var lifts: [Lift]
    
    @State private var isShowingAddSheet = false
    @State private var isError = false
    @State private var errorString = ""
    
    var liftRepo: AppRepository
    
    init(lifts: Binding<[Lift]>, liftRepo: AppRepository) {
        self.liftRepo = liftRepo
        self._lifts = lifts
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($lifts, id: \.self) { $lift in
                        NavigationLink(
                            destination: LiftDetailView(lift: $lift, liftRepository: liftRepo))
                        {
                            LiftLineItemView(lift: lift)
                        }
                    }
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("add"){
                        isShowingAddSheet = true
                    }.sheet(isPresented: $isShowingAddSheet){
                        AddLiftView(liftRepo: liftRepo, lifts: $lifts)
                    }
                }
            }
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
        return LiftsView(lifts: .constant([squat]), liftRepo: liftRepo)
    }
}
