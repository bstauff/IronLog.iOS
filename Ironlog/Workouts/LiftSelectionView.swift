//
//  LiftSelectionView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/1/22.
//

import SwiftUI

struct LiftSelectionView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<LiftModel>
    
    @State var selectedLift: Lift?
    
    var body: some View {
        Picker("Lift", selection: $selectedLift) {
            ForEach(lifts) { lift in
                Text(lift.name ?? "").tag(lift as LiftModel?)
            }
        }
    }
}

struct LiftSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        return LiftSelectionView().environment(\.managedObjectContext, viewContext)
    }
}
