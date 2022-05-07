//
//  DataController.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/7/22.
//

import Foundation
import CoreData

public class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Ironlog")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to tload: \(error.localizedDescription)")
            }
        }
    }
}
