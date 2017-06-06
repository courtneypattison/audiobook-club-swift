//
//  Runtime.swift
//  AudiobookClub
//
//  Created by Courtney Pattison on 2017-06-06.
//  Copyright © 2017 Courtney Pattison. All rights reserved.
//

import Foundation

struct Runtime {
    
    // Mark: Properties
    
    let hours: Int
    let minutes: Int
    let seconds: Int
    
    // Mark: Initialization
    
    init?(string runtime: String) {
        let runtimeArray = runtime.components(separatedBy: ":")
        if runtimeArray.count == 3 {
            if let hours = Int(runtimeArray[0]),
               let minutes = Int(runtimeArray[1]),
               let seconds = Int(runtimeArray[2]) {
                self.hours = hours
                self.minutes = minutes
                self.seconds = seconds
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    // Mark: Methods
    
    func description() -> String {
        if hours == 0 {
            return "\(minutes)m"
        } else {
            return "\(hours)h \(minutes)m"
        }
    }
}
