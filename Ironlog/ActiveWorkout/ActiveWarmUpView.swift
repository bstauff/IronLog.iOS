//
//  ActiveWarmUpView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/31/22.
//

import SwiftUI

struct ActiveWarmUpView: View {
    
    var onComplete: () -> Void
    
    var body: some View {
        VStack {
            Text("Active Warm up!")
            Spacer()
            Button("Complete", action: onComplete)
        }
    }
}

struct ActiveWarmUpView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveWarmUpView {
            
        }
    }
}
