//
//  MusicPlayerView.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import MediaPlayer
import ExAuto

class MusicPlayerView: UIView {
    //MARK: - Properties

    lazy var playPauseButton: ExButton = ExButton.init(frame: CGRectZero)
    lazy var playNextButton: ExButton  = ExButton.init(frame: CGRectZero)
    lazy var playPreviousButton: ExButton = ExButton.init(frame: CGRectZero)
    lazy var playMenuButton: ExButton  = ExButton.init(frame: CGRectZero)
    lazy var playProgressBar: UIProgressView = UIProgressView.init(frame: CGRectZero)
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutMusicPlayer(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Accessors
    // 初始化MusicPlayerView
    private func layoutMusicPlayer(frame: CGRect) {
        
        self.addSubview(playPauseButton)
        self.addSubview(playNextButton)
        self.addSubview(playPreviousButton)
        self.addSubview(playMenuButton)
        self.addSubview(playProgressBar)
        
        playPreviousButton.translatesAutoresizingMaskIntoConstraints = false
        let playPreviousButtonContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: playPreviousButton, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 10)
        let playPreviousButtonContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playPreviousButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 15.0)
        let playPreviousButtonContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: playPreviousButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let playPreviousButtonContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: playPreviousButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let playPreviousButtonContrains: NSArray = [playPreviousButtonContrainTop, playPreviousButtonContrainWidth, playPreviousButtonContrainHeight, playPreviousButtonContrainLeading]
        self.addConstraints(playPreviousButtonContrains as! [NSLayoutConstraint])
        playPreviousButton.setBackgroundImage(UIImage(named: "homeMusic-previousMusic"), forState: .Normal)
        playPreviousButton.tag = 1001
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        let playPauseButtonContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: playPauseButton, attribute: .Leading, relatedBy: .Equal, toItem: playPreviousButton, attribute: .Trailing, multiplier: 1.0, constant: 10.0)
        let playPauseButtonContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playPauseButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 10.0)
        let playPauseButtonContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: playPauseButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0)
        let playPauseButtonContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: playPauseButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0)
        let playPauseButtonContrains: NSArray = [playPauseButtonContrainTop, playPauseButtonContrainWidth, playPauseButtonContrainHeight, playPauseButtonContrainLeading]
        self.addConstraints(playPauseButtonContrains as! [NSLayoutConstraint])
        playPauseButton.setBackgroundImage(UIImage(named: "homeMusic-play"), forState: .Normal)
        playPauseButton.tag = 1002
        
        playNextButton.translatesAutoresizingMaskIntoConstraints = false
        let playNextButtonContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: playNextButton, attribute: .Leading, relatedBy: .Equal, toItem: playPauseButton, attribute: .Trailing, multiplier: 1.0, constant: 10.0)
        let playNextButtonContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playNextButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 15.0)
        let playNextButtonContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: playNextButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let playNextButtonContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: playNextButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let playNextButtonContrains: NSArray = [playNextButtonContrainTop, playNextButtonContrainWidth, playNextButtonContrainHeight, playNextButtonContrainLeading]
        self.addConstraints(playNextButtonContrains as! [NSLayoutConstraint])
        playNextButton.setBackgroundImage(UIImage(named: "homeMusic-nextMusic"), forState: .Normal)
        playNextButton.tag = 1003
        
        playMenuButton.translatesAutoresizingMaskIntoConstraints = false
        let playMenuButtonContrainTrailing: NSLayoutConstraint = NSLayoutConstraint.init(item: playMenuButton, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -10.0)
        let playMenuButtonContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playMenuButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 15.0)
        let playMenuButtonContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: playMenuButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let playMenuButtonContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: playMenuButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let playMenuButtonContrains: NSArray = [playMenuButtonContrainTop, playMenuButtonContrainWidth, playMenuButtonContrainHeight, playMenuButtonContrainTrailing]
        self.addConstraints(playMenuButtonContrains as! [NSLayoutConstraint])
        playMenuButton.setBackgroundImage(UIImage(named: "homeMusic-menu"), forState: .Normal)
        playMenuButton.tag = 1004
        
        playProgressBar.translatesAutoresizingMaskIntoConstraints = false
        let playProgressBarContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: playProgressBar, attribute: .Leading, relatedBy: .Equal, toItem: playNextButton, attribute: .Trailing, multiplier: 1.0, constant: 10.0)
        let playProgressBarContrainTrailing: NSLayoutConstraint = NSLayoutConstraint.init(item: playProgressBar, attribute: .Trailing, relatedBy: .Equal, toItem: playMenuButton, attribute: .Leading, multiplier: 1.0, constant: -10.0)
        let playProgressBarContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playProgressBar, attribute: .Top, relatedBy: .Equal, toItem: playNextButton, attribute: .Top, multiplier: 1.0, constant: 14.0)
        let playProgressBarContrainBottom: NSLayoutConstraint = NSLayoutConstraint.init(item: playProgressBar, attribute: .Bottom, relatedBy: .Equal, toItem: playNextButton, attribute: .Bottom, multiplier: 1.0, constant: -13.0)
        let playProgressBarContrains: NSArray = [playProgressBarContrainLeading, playProgressBarContrainBottom, playProgressBarContrainTop, playProgressBarContrainTrailing]
        self.addConstraints(playProgressBarContrains as! [NSLayoutConstraint])
        playProgressBar.progressTintColor = UIColor.init(red: 255.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    //MARK: - iCarousel DataSource
}
