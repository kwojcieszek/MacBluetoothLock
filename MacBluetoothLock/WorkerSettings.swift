//
//  WorkerSettings.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 20/02/2023.
//

import Foundation

struct WorkerSettings : Codable {
    var timeBeforeLock:Int = 15
    var deviceName:String = ""
    var connectedBeforeScreenLock:Bool = true
    var enableScreenLock:Bool = false
}
