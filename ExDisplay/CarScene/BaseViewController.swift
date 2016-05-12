//
//  BaseViewController.swift
//  ExDisplay
//
//  Created by elsie on 16/4/11.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit
import ExAuto

let BTN_BACK = 0;

class BaseViewController: UIViewController,ExDisplayControlProtocol {

    var defaultFocusView : UIView!
    var secondScreenView : UIView?
    var externalWindow:UIWindow?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExControlCenter.sharedInstance()!.displayControlDelegate = self
        ExControlCenter.sharedInstance()!.setFocusForView(defaultFocusView)
        secondScreenView = self.view
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// ExControlProtocol
    func confirm() {
        let curView : UIView? = ExControlCenter.sharedInstance()!.focusView
        let viewTag : Int = curView!.tag
        switch viewTag {
        case 0:
            break
            
        default:
            break
            
        }
    }
   
    func back() {
        
    }
    
    func voiceChange(voiceAmountScale:Float) {
        
    }
    
    func showMenu() {
        
    }
    
    func hideMenu() {
        
    }
    
    func showSiri() {
        
    }
    
    func hideSiri() {
        
    }
    
    func performOrderWithString(order:ExVROrder, str:String?){
        
    }
    
    func BLEStatus(status:Bool){
        
    }
}

