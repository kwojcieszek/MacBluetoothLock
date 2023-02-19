//
//  Worker.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 19/02/2023.
//

import Foundation

class Worker{
    
    private var timer: Timer?
    private var seconds:Int = 0
    private var secondsHavePassed = 0
    private var deviceName:String = ""
    private var connectedBeforeScreenLock:Bool = true
    private let bluetoothDevices = BluetoothDevices()
    private let screenLock = ScreenLock()
    
    private static var worker: Worker = {
            let worker = Worker()
            return worker
    }()

    class func shared() -> Worker {
            return worker
    }
    
    func start(_ seconds:Int,_ deviceName:String,_ connectedBeforeScreenLock:Bool){
        
        self.seconds = seconds
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
        
        if(bluetoothDevices.isConnected(self.deviceName)){
            secondsHavePassed = 0
        }else{
            secondsHavePassed+=1
        }

        if(secondsHavePassed>=seconds){
            secondsHavePassed = 0
            screenLock.lock()
        }
    }
}
