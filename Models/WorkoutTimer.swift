//
//  WorkoutTimer.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/28/23.
//

import Foundation
class WorkoutTimer: ObservableObject {
    @Published var secondsRemaining = 0
    @Published var timerStopped = false
    
    private var timer: Timer?
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    
    private var secondsForCountdown: Int
    
    init(secondsForCountDown: Int) {
        self.secondsForCountdown = secondsForCountDown
    }
    
    func startTimer() {
        self.startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                
                self.secondsRemaining = self.secondsForCountdown - Int(secondsElapsed)
                
                if self.secondsRemaining == 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.timerStopped = true
                }
            }
        }
    }
}
