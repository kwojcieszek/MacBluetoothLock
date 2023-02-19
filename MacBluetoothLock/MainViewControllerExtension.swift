//
//  MainViewControllerExtension.swift
//  MacBluetoothLock
//
//  Created by Kamil Wojcieszek on 18/02/2023.
//

import Foundation
import AppKit

extension MainViewController {
  // MARK: Storyboard instantiation
    static func freshController() -> MainViewController {
    //1.
      let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //2.
      let identifier = NSStoryboard.SceneIdentifier("MainViewController")
    //3.
      guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MainViewController else {
      fatalError("Why cant i find MainViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
