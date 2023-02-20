//
//  WorkerSettingsExtenssion.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 20/02/2023.
//

import Foundation


extension WorkerSettings{
    
    static func getSettingsFromJson()->WorkerSettings?{
         return JsonHandling<WorkerSettings>().Encoder("workerSettings")
    }
    
    static func setSettingsToJson(_ workerSettings:WorkerSettings){
        JsonHandling<WorkerSettings>().Decoder("workerSettings", workerSettings)
    }
}
