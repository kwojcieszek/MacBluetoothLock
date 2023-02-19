//
//  QuotesViewController.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 18/02/2023.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var listOfDevices: NSComboBox!
    @IBOutlet weak var timeOfSeconds: NSTextField!
    @IBOutlet weak var timeOfSecondsStepper: NSStepper!
    @IBOutlet weak var connectedBeforeScreenLock: NSSwitch!
    @IBOutlet weak var enableScreenLock: NSSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listOfDevices.addItems(withObjectValues: BluetoothDevices().pairedDevices())
        
        timeOfSeconds.stringValue = timeOfSecondsStepper.stringValue
    }

    override var representedObject: Any? {
        didSet {
       
        }
    }
    
    @IBAction func timeOfSecondsStepperAction(_ sender: NSStepper) {
        timeOfSeconds.stringValue = timeOfSecondsStepper.stringValue
    }
    
    @IBAction func connectedBeforeScreenLockAction(_ sender: NSSwitch) {
    }
    
    
    @IBAction func enableScreenLockAction(_ sender: NSSwitch) {
        
        if(self.enableScreenLock.state == NSControl.StateValue.on){
            Worker.shared().start(5,"AirPods Pro",true)
        }else{
            Worker.shared().stop()
        }
            
    }
}
