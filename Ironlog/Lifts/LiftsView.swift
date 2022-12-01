//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<LiftModel>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(lifts) { lift in
//                        NavigationLink(
//                            destination: LiftDetailView(lift: $lift, liftRepository: liftRepo))
//                        {
//                            LiftLineItemView(lift: lift)
//                        }
                            LiftLineItemView(liftModel: lift)
                    }
                }
            }
            .navigationTitle("Lift Catalog")
        }
    }
}

struct LiftsView_Previews: PreviewProvider {
    static var previews: some View {
        return LiftsView()
    }
}
