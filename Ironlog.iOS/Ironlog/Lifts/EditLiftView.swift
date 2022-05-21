//
//  LiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct EditLiftView: View {
    @ObservedObject var lift: Lift
    
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

struct EditLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = Lift(name: "squat", trainingMax: 350)
        return EditLiftView(lift: liftModel)
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
