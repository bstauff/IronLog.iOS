//
//  AddLiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/25/22.
//

import SwiftUI

struct AddLiftView: View {
    @ObservedObject var liftCatalog: LiftCatalog
    
    @State private var name: String?
    @State private var trainingMax: Int?
    
    var body: some View {
        HStack {
            VStack {
                Text(
                    "Lift Name")
                TextField(
                    "Lift Name",
                    text: $name,
                )
                .textFieldStyle(.automatic)
            }
        }
    }
}

struct AddLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let liftCatalog = LiftCatalog()
        AddLiftView(liftCatalog: liftCatalog)
    }
}
