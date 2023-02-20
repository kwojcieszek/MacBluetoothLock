//
//  bt.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 19/02/2023.
//

import Foundation
import IOBluetooth

class BluetoothDevices {

    func pairedDevices() -> Array<String> {

        var devicesNames = Array<String>()

        guard let devices = IOBluetoothDevice.pairedDevices() else {
            return devicesNames
        }
        
        for item in devices {
            if let device = item as? IOBluetoothDevice {
                devicesNames.append(device.name)
            }
        }

        return devicesNames
    }

    func isConnected(_ deviceName: String) -> Bool {
        guard let devices = IOBluetoothDevice.pairedDevices() else {
            return false
        }

        for item in devices {
            if let device = item as? IOBluetoothDevice {
                if(device.name == deviceName) {
                    return device.isConnected()
                }
            }
        }

        return false
    }
}
