//
//  PhoneViewController.swift
//  ExDisplay
//  手机屏幕view
//  Created by elsie on 16/4/11.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit
import ExAuto

class PhoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view = UIView(frame:CGRectZero)
        
        let label = UILabel(frame:CGRectMake(100, 100, 150, 50))
        label.text = "注意驾驶安全！"
        
        self.view.addSubview(label)
        
        let button = UIButton(frame:CGRectMake(100, 300, 150, 50))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: #selector(PhoneViewController.clickButton), forControlEvents: .TouchDown)
        self.view.addSubview(button)
    }
    func clickButton() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("gotoContactsNotification", object: title)
    }
    
}

