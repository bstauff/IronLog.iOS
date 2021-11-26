//
//  LiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import SwiftUI
struct LiftDetailView: View {

    @ObservedObject var lift: Lift
    var body: some View {
        HStack {
            Text(lift.liftName)
            Text(String(lift.trainingMax))
        }
    }
}

struct LiftView_Previews: PreviewProvider {
    static var previews: some View {
        LiftDetailView(lift: Lift(liftName: "Squat", trainingMax: 350))
    }
}
