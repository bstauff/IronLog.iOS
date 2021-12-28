//
//  AddLiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/24/21.
//

import SwiftUI

struct LiftDetailView: View {
    @Binding var liftToEdit:Lift
    
    var body: some View {
        Form {
            Section(header: Text("Lift Name")) {
                TextField("", text: $liftToEdit.liftName)
            }
            Section(header: Text("Training Max")) {
                TextField("Training Max", value: $liftToEdit.trainingMax, formatter: NumberFormatter())
            }
        }
    }
}

struct LiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LiftDetailView(liftToEdit: .constant(Lift(liftName: "fake lift", trainingMax: 250)))
    }
}
