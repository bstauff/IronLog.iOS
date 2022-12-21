//
//  LiftsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftsView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<LiftModel>
    
    @State private var isShowingAddLiftSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(lifts) { lift in
                        NavigationLink(destination: LiftDetailView(lift: lift)) {
                            LiftLineItemView(liftModel: lift)
                        }
                    }
                }
            }
            .navigationTitle("Lift Catalog")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {() -> Void in self.isShowingAddLiftSheet = true}) {
                        Image(systemName: "plus.circle.fill")
                    }.sheet(isPresented: $isShowingAddLiftSheet) {
                        AddLiftView()
                    }
                }
            }
        }
    }
}

struct LiftsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        return LiftsView().environment(\.managedObjectContext, viewContext)
    }
}
