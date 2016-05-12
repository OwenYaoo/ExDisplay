//
//  MusicPlayerListTabelView.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicPlayerListView: UIView {
    lazy var playMusicListTableView: UITableView = UITableView.init(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutPlayMusicListTableView(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化播放列表tableView
    private func layoutPlayMusicListTableView(frame: CGRect) {
        self.addSubview(playMusicListTableView)
        playMusicListTableView.translatesAutoresizingMaskIntoConstraints = false
        let playMusicListTableViewContrainLeft: NSLayoutConstraint = NSLayoutConstraint.init(item: playMusicListTableView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let playMusicListTableViewContrainRight: NSLayoutConstraint = NSLayoutConstraint.init(item: playMusicListTableView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let playMusicListTableViewContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playMusicListTableView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let playMusicListTableViewContrainBottom: NSLayoutConstraint = NSLayoutConstraint.init(item: playMusicListTableView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let playMusicListTableViewConstraints: NSArray = [playMusicListTableViewContrainTop,playMusicListTableViewContrainLeft,playMusicListTableViewContrainRight,playMusicListTableViewContrainBottom]
        self.addConstraints(playMusicListTableViewConstraints as! [NSLayoutConstraint])
        playMusicListTableView.hidden = true
    }
}
