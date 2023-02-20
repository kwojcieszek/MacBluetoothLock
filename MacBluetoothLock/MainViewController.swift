//
//  QuotesViewController.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 18/02/2023.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var listOfDevices: NSComboBox!
    @IBOutlet weak var timeBeforeLock: NSTextField!
    @IBOutlet weak var timeBeforeLockStepper: NSStepper!
    @IBOutlet weak var connectedBeforeScreenLock: NSSwitch!
    @IBOutlet weak var enableScreenLock: NSSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listOfDevices.addItems(withObjectValues: BluetoothDevices().pairedDevices())
        
        guard let workerSettings = WorkerSettings.getSettingsFromJson() else{
            return
        }
        
        self.listOfDevices.selectItem(withObjectValue: workerSettings.deviceName)
        self.timeBeforeLock.stringValue = String(workerSettings.timeBeforeLock)
        self.connectedBeforeScreenLock.state = workerSettings.connectedBeforeScreenLock ? .on : .off
        self.enableScreenLock.state = workerSettings.enableScreenLock ? .on : .off
    }
    
    @IBAction func timeBeforeLockStepperAction(_ sender: NSStepper) {
        self.timeBeforeLock.stringValue = self.timeBeforeLockStepper.stringValue
        self.setWorkerSettingsAndStart()
    }
    
    @IBAction func workerSettingsAction(_ sender: Any) {
        self.setWorkerSettingsAndStart()
    }
    
    private func createWorkerSettings()->WorkerSettings{
        
        var workerSettings = WorkerSettings()
        workerSettings.deviceName = self.listOfDevices.stringValue
        workerSettings.timeBeforeLock = Int(self.timeBeforeLock.stringValue) ?? workerSettings.timeBeforeLock
        workerSettings.connectedBeforeScreenLock = self.connectedBeforeScreenLock.state == .on ? true : false
        workerSettings.enableScreenLock = self.enableScreenLock.state == .on ? true : false
        return workerSettings
    }
    
    private func setWorkerSettingsAndStart(){
        let workerSettings = self.createWorkerSettings()
        WorkerService().setConfigAndStartOrRestart(workerSettings)
    }
}
