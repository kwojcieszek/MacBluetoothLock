//
//  Worker.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 19/02/2023.
//

import Foundation

class Worker{
    
    private var timer: Timer?
    private var timeBeforeLock:Int = 0
    private var timeHavePassed = 0
    private var deviceName:String = ""
    private var connectedBeforeScreenLock:Bool = true
    private var connected:Bool = false
    private let bluetoothDevices = BluetoothDevices()
    private let screenLock = ScreenLock()
    
    private static var worker: Worker = {
            let worker = Worker()
            return worker
    }()

    class func shared() -> Worker {
            return worker
    }
    
    func start(_ timeBeforeLock:Int,_ deviceName:String,_ connectedBeforeScreenLock:Bool){
        
        self.timeBeforeLock = timeBeforeLock
        self.deviceName = deviceName
        self.connectedBeforeScreenLock = connectedBeforeScreenLock
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(bluetoothCheckerAction), userInfo: nil, repeats: true)
    }
    
    func stop(){
        
        guard let timer = self.timer else {
            return;
        }
        
        timer.invalidate()
    }
    
    @objc func bluetoothCheckerAction() {
        
        if(self.deviceName == ""){
            return
        }
        
        if(bluetoothDevices.isConnected(self.deviceName)){
            self.connected = true
            self.timeHavePassed = 0
        }else{
            self.timeHavePassed+=1
        }

        if(self.timeHavePassed>=self.timeBeforeLock && ((self.connectedBeforeScreenLock == true && self.connected == true) || self.connectedBeforeScreenLock == false)){
            self.connected = false
            self.timeHavePassed = 0
            self.screenLock.lock()
        }
    }
}
