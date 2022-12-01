//
//  LiftSelectionView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/1/22.
//

import SwiftUI

struct LiftSelectionView: View {
    
    private var lifts: [Lift]
    
    @State var selectedLift: Lift?
    
    init(lifts: [Lift]) {
        self.lifts = lifts
    }
    
    var body: some View {
        Picker("Lift", selection: $selectedLift) {
            ForEach(lifts) { lift in
                Text(lift.name).tag(lift as Lift?)
            }
        }
    }
}

struct LiftSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let lifts = [
            Lift(name: "Squat", trainingMax: 350),
            Lift(name: "Bench", trainingMax: 300)
        ]
        
        LiftSelectionView(lifts: lifts)
    }
}
