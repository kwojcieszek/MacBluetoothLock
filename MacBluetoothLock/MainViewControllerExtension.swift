//
//  MainViewControllerExtension.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 18/02/2023.
//

import Foundation
import AppKit

extension MainViewController {

    static func freshController() -> MainViewController {
      let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
      let identifier = NSStoryboard.SceneIdentifier("MainViewController")
      guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainViewController else {
      fatalError("Why cant i find MainViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
