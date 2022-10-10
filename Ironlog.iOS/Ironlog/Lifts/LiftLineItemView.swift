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
        Text(lift.name)
    }
}

struct LiftLineItemView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = Lift(name: "squat", trainingMax: 350)
        LiftLineItemView(lift: liftModel)
    }
}
