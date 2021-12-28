//
//  IronlogApp.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI

@main
struct IronlogApp: App {
    
    @StateObject var liftCatalog = MockLiftService().getLiftCatalog()
    
    var body: some Scene {
        WindowGroup {
            LobbyView().environmentObject(liftCatalog)
        }
    }
}
