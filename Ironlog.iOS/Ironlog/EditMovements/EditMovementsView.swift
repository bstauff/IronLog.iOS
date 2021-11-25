//
//  TrainingWeightView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/8/21.
//

import SwiftUI

struct EditMovementsView: View {

    @State private var movements: [Movement] = []
    
    var body: some View {
        VStack {
            ForEach(0..<movements.count){ index in
                Text(movements[index].lift.liftName)
            }
        }
        .onAppear(perform: { loadMovements() })
    }
    
    private func loadMovements() {
        let mockDataService = MockLiftingSessionService()
        for _ in 0...5 {
            self.movements.append(mockDataService.getMovement())
        }
    }
}

struct EditMovementsView_Previews: PreviewProvider {
    static var previews: some View {
        EditMovementsView()
    }
}
