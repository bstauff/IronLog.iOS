//
//  AddLiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/24/21.
//

import SwiftUI

struct LiftDetailView: View {
    @ObservedObject var liftToEdit:Lift
    
    var body: some View {
        VStack {
            Text("Add Lift").font(Font.title)
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
}

struct LiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LiftDetailView(liftToEdit: Lift(liftName: "fake lift", trainingMax: 250))
    }
}
