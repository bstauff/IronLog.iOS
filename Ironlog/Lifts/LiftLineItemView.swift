//
//  LiftCatalogItem.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/2/22.
//

import SwiftUI

struct LiftLineItemView: View {
    @ObservedObject var liftModel: LiftModel
    
    var body: some View {
        Text(liftModel.name ?? "unknown")
    }
}

struct LiftLineItemView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = LiftModel(context: PersistenceController.preview.container.viewContext)
        liftModel.name = "Test Lift"
        liftModel.trainingMax = 999
        return LiftLineItemView(liftModel: liftModel)
    }
}
