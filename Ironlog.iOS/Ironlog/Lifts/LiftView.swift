//
//  LiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct LiftView: View {
    @Binding var lift: Lift
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack {
                Text("Lift Name")
                TextField("Lift Name", text: $lift.name).textFieldStyle(.roundedBorder)
                Text("Training Max")
                TextField("Training Max", value: $lift.trainingMax, formatter: numberFormatter).textFieldStyle(.roundedBorder)
            }
        }
    }
}

struct LiftView_Previews: PreviewProvider {
    static var previews: some View {
        let lift = Lift(name: "Squat", trainingMax: 315)
        return LiftView(lift: .constant(lift))
    }
}
