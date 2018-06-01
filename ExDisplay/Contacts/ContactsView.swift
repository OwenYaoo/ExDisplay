；//
//  ContactsView.swift
//  swif_tableView
//
//  Created by mapbarDaLian on 16/4/27.
//  Copyright © 2016年 owenyao. All rights reserved.
//

import UIKit

class ContactsView: UIView {
    //背景图
    var backgroundImageView : UIImageView
    //联系人数据tableview
    var contactsTableView : UITableView
    
    var titleLabel : UILabel
    //照片
    var photoImage :  UIImageView
    //姓名
    var nameLabel : UILabel
    //电话信息View
    var infoScrollView  : UIScrollView
    //背景图片上面透明层
    var hyalinelayerView : UIView
    
    

    

    override init(frame: CGRect) {
    
        backgroundImageView = UIImageView(frame : CGRectZero)
        backgroundImageView.image = UIImage.init(named: "ContactsBackgroundImage.png")
        contactsTableView = UITableView(frame: CGRectZero, style: .Plain)
        titleLabel = UILabel(frame: CGRectZero)
        photoImage = UIImageView(frame: CGRectZero)
        nameLabel = UILabel(frame: CGRectZero)
        infoScrollView = UIScrollView(frame: CGRectZero)
        
        hyalinelayerView = UIView(frame: CGRectZero)
    
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        self.addSubview(hyalinelayerView)
        self.hyalinelayerView.addSubview(contactsTableView)
        self.hyalinelayerView.addSubview(titleLabel)
        self.hyalinelayerView.addSubview(photoImage)
        self.hyalinelayerView.addSubview(nameLabel)
        self.hyalinelayerView.addSubview(infoScrollView)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let nWidth = self.frame.size.width;
        let nHeight = self.frame.size.height;
        let screenRate = UIScreen.screens()[1].bounds.width/UIScreen.screens()[0].bounds.width
        let widthBorder : CGFloat = 30*screenRate
        let heightBorder : CGFloat = 20*screenRate
        
        
        
        if nWidth < nHeight {//竖屏
        
        
        
        }else{
            
            backgroundImageView.frame = CGRectMake(0,0, UIScreen.screens()[1].bounds.width, UIScreen.screens()[1].bounds.height)
            
            hyalinelayerView.frame = CGRectMake(widthBorder, heightBorder, UIScreen.screens()[1].bounds.width - widthBorder * 2, UIScreen.screens()[1].bounds.height - heightBorder * 2)
            hyalinelayerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.62)
            
            titleLabel.frame = CGRectMake(0,0,hyalinelayerView.frame.width/2, 50)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.text = "手机联系人"
            titleLabel.textColor = UIColor.whiteColor()
           // titleLabel.backgroundColor = UIColor.redColor()
            contactsTableView.frame = CGRectMake(0, titleLabel.frame.maxY,hyalinelayerView.frame.width/2,hyalinelayerView.frame.maxY - titleLabel.frame.maxY - 30*screenRate);
            print(hyalinelayerView.frame.maxY)
            print(titleLabel.frame.maxY)
            contactsTableView.backgroundColor = UIColor.clearColor()
            
            photoImage.frame = CGRectMake(contactsTableView.frame.maxX + widthBorder, titleLabel.frame.maxY, 50*screenRate, 50*screenRate)
          //  photoImage.backgroundColor = UIColor.redColor()
            photoImage.layer.cornerRadius = 25*screenRate
            photoImage.layer.masksToBounds = true
            
            nameLabel.frame = CGRectMake(photoImage.frame.maxX + 10*screenRate, photoImage.frame.maxY - 30*screenRate, 50*screenRate, 30*screenRate)
            nameLabel.textColor = UIColor.whiteColor()
            //nameLabel.backgroundColor = UIColor.redColor()
            infoScrollView.frame = CGRectMake(photoImage.frame.minX, photoImage.frame.maxY + 20*screenRate, hyalinelayerView.frame.width/2-widthBorder*2, hyalinelayerView.frame.height - photoImage.frame.maxY - heightBorder*2)
            infoScrollView.layer.borderWidth = 1.0
            infoScrollView.layer.borderColor = UIColor.lightGrayColor().CGColor

        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
