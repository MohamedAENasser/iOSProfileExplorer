//
//  CountdownTimer.swift
//  ProfileExplorer
//
//  Created by Mohamed Abd ElNasser on 27/04/2025.
//

import Foundation

class CountdownTimer {
    private var timer: Timer?
    
    func start(endDate: Date, update: @escaping (String) -> Void) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let now = Date()
            let remaining = endDate.timeIntervalSince(now)
            
            if remaining <= 0 {
                update("Ended")
                self.timer?.invalidate()
            } else {
                let hours = Int(remaining) / 3600
                let minutes = (Int(remaining) % 3600) / 60
                let seconds = Int(remaining) % 60
                update(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
