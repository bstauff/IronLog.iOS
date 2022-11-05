//
//  LiftView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct EditLiftView: View {
    @State private var isError = false
    @State private var errorString = ""
    
    @State private var updatedLiftName: String = ""
    @State private var updatedTrainingMax: Int = 0
    
    @Binding var lift: Lift
    
    private var liftRepository: AppRepository
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        return formatter
    }()
    
    init(lift: Binding<Lift>, liftRepository: AppRepository){
        self._lift = lift
        self.liftRepository = liftRepository
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Lift Name")
                TextField("Lift Name", text: $updatedLiftName).textFieldStyle(.roundedBorder)
                Text("Training Max")
                TextField("Training Max", value: $updatedTrainingMax, formatter: numberFormatter).textFieldStyle(.roundedBorder)
                Button("Save", action: saveLift)
            }
            .alert(isPresented: $isError) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorString),
                    dismissButton: .default(Text("OK"))
                )
            }
        }.onAppear {
            self.updatedLiftName = lift.name
            self.updatedTrainingMax = lift.trainingMax
        }
    }
    
    
    func saveLift() {
        guard updatedLiftName != "" else {
            isError = true
            errorString = "lift name is required"
            return
        }
        
        guard updatedTrainingMax > 0 else {
            isError = true
            errorString = "training max is required"
            return
        }
        
        do {
            try liftRepository.saveLift(lift: lift)
        } catch {
            isError = true
            errorString = "failed to save lift"
            return
        }
        
        lift.trainingMax = updatedTrainingMax
        lift.name = updatedLiftName
    }
}

struct EditLiftView_Previews: PreviewProvider {
    static var previews: some View {
        let liftModel = Lift(name: "squat", trainingMax: 350)
        let liftRepo = CoreDataRepository()
        return EditLiftView(lift: .constant(liftModel), liftRepository: liftRepo)
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
