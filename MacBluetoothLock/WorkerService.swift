//
//  WorkerService.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 20/02/2023.
//

import Foundation

class WorkerService{
    
    func getConfigAndStartIfExist(){

        guard let workerSettings = WorkerSettings.getSettingsFromJson() else{
            return
        }
        
        if(workerSettings.enableScreenLock){
            Worker.shared().start(workerSettings.timeBeforeLock,workerSettings.deviceName,workerSettings.connectedBeforeScreenLock)
        }
    }
    
    func setConfigAndStartOrRestart(_ workerSettings:WorkerSettings){
        
        WorkerSettings.setSettingsToJson(workerSettings)
        
        Worker.shared().stop()
        
        if(workerSettings.enableScreenLock){
            Worker.shared().start(workerSettings.timeBeforeLock,workerSettings.deviceName,workerSettings.connectedBeforeScreenLock)
        }
    }
}
