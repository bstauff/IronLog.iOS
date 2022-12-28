//
//  LiftCatalogItem.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/2/22.
//

import SwiftUI

struct LiftLineItemView: View {
    @ObservedObject var lift: Lift
    
    var body: some View {
        Text(lift.name ?? "unknown")
    }
}

struct LiftLineItemView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = Lift(context: PersistenceController.preview.container.viewContext)
        liftModel.name = "Test Lift"
        liftModel.trainingMax = 999
        return LiftLineItemView(lift: liftModel)
    }
}
