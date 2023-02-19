//
//  ScreenLock.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 17/02/2023.
//

import Foundation

class ScreenLock{
    
    func lock() {
        let libHandle = dlopen("/System/Library/PrivateFrameworks/login.framework/Versions/Current/login", RTLD_LAZY)
        let sym = dlsym(libHandle, "SACLockScreenImmediate")
        typealias myFunction = @convention(c) () -> Void
        
        let SACLockScreenImmediate = unsafeBitCast(sym, to: myFunction.self)
        SACLockScreenImmediate()
    }
}
