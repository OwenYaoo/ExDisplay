//
//  SecondScreenLauncher.swift
//  ExDisplay
//  管理二屏的显示，连接，断开的处理
//  Created by elsie on 16/4/28.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import UIKit
import ExAuto
class SecondScreenLauncher {
    
    var secondWindow : UIWindow?
    
    //第二屏的显示
    func initSecondScreen() -> Bool {
        if UIScreen.screens().count > 1 {
            let secondScreen : UIScreen? = UIScreen.screens()[1]
            
            self.secondWindow = UIWindow(frame: secondScreen!.bounds)
            self.secondWindow!.backgroundColor = UIColor.whiteColor()
            self.secondWindow!.screen = secondScreen!
            self.secondWindow!.hidden = false
            
            let carViewController = LauncherViewController()
            ExControlCenter.sharedInstance()!.displayControlDelegate = carViewController
            ExControlCenter.sharedInstance()?.displayControlDelegate?.externalWindow = self.secondWindow
            let naviController = UINavigationController(rootViewController: carViewController)
            naviController.navigationBarHidden = true;
            
            self.secondWindow?.rootViewController = naviController
            self.secondWindow?.makeKeyAndVisible()
            
            return true
        }
        return false
    }
    
    //收到连接二屏的通知，触发的回调方法，进行二屏显示
    @objc func handleScreenDidConnectNotification(note:NSNotification) {
        let newScreen = note.object as! UIScreen
        
        if self.secondWindow == nil {
            self.secondWindow = UIWindow(frame: newScreen.bounds)
            self.secondWindow!.screen = newScreen;
            self.secondWindow!.backgroundColor = UIColor.whiteColor()
            self.secondWindow!.hidden = false
            
            let carViewController = LauncherViewController()
            let naviController = UINavigationController(rootViewController: carViewController)
            naviController.navigationBarHidden = true;
            
            self.secondWindow?.rootViewController = naviController
            self.secondWindow?.makeKeyAndVisible()
            
//            setupScreenConnectionNotificationHandlers()
        }
    }
    
    //收到二屏断开的通知，触发的回调方法，进行二屏显示
    @objc func handleScreenDidDisconnectNotification(note:NSNotification){
        if (self.secondWindow != nil) {
            self.secondWindow!.hidden = true;
            self.secondWindow = nil;
        }
    }
    
}