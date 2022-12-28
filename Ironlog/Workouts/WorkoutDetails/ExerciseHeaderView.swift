//
//  ExerciseHeaderView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI

struct ExerciseHeaderView: View {
    var headerTitle: String
    
    var onAddClicked: () -> Void
    
    var isAddDisabled: () -> Bool
    
    var body: some View {
        HStack {
            Text(headerTitle)
            Spacer()
            Button(action: onAddClicked) {
                Image(systemName: "plus.circle.fill")
            }
            .disabled(isAddDisabled())
        }
    }
}

struct ExerciseHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseHeaderView(
            headerTitle: "Main work",
            onAddClicked: {() -> Void in },
            isAddDisabled: {() -> Bool in true}
        )
    }
}
