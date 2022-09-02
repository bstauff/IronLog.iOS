//
//  LiftCatalogItem.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/2/22.
//

import SwiftUI

struct LiftCatalogItem: View {
    @ObservedObject var lift: Lift
    var body: some View {
        Text(lift.name)
    }
}

struct LiftCatalogItem_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = Lift(name: "squat", trainingMax: 350)
        LiftCatalogItem(lift: liftModel)
    }
}
