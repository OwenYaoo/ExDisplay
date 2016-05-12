//
//  MusicViewController.swift
//  ExDisplay
//
//  Created by mapbarDaLian on 16/4/11.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit
import ExAuto
import Foundation
import MediaPlayer

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MusicPlayerDelegate {
    
    var isPlaying: Bool = false
    var musicPlayerView = MusicPlayerView()
    var musicPlayerListView = MusicPlayerListView()
    
    var musicPlayer: MusicPlayer!
    var musicPlayerModel: MusicPlayerModel!
    let musicListNameArray: NSMutableArray = NSMutableArray()
    
    lazy var playTitleLabel: UILabel = UILabel.init(frame: CGRectZero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMusiPlayer()
        
        initBaseView()
    }
    
    //MARK: - Private
    private func initMusiPlayer() {
        musicPlayerModel = MusicPlayerModel.init()
        musicPlayer = MusicPlayer.init()
        musicPlayer.delegate = self
        let mediaItemCollection = musicPlayerModel.musicMediaItemCollectionWithMediaGrouping(.Title)
        if mediaItemCollection.count > 0 {
            let songs = mediaItemCollection.items
            let playingItem = songs[0] as MPMediaItem
            musicPlayer.setMediaPlayerWithItemCollection(mediaItemCollection, nowPlayingItem: playingItem)
            
            for item in mediaItemCollection.items {
                let musicName = item.valueForProperty(MPMediaItemPropertyTitle)
                musicListNameArray.addObject(musicName!)
            }
        }
    }
    
    private func initBaseView() {
        
        // 歌曲名Label
        self.view.addSubview(playTitleLabel)
        playTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        let playTitleLabelContrainLeft: NSLayoutConstraint = NSLayoutConstraint.init(item: playTitleLabel, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        let playTitleLabelContrainRight: NSLayoutConstraint = NSLayoutConstraint.init(item: playTitleLabel, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: 0.0)
        let playTitleLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: playTitleLabel, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 40.0)
        let playTitleLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: playTitleLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 20.0)
        let playTitleLabelConstraints: NSArray = [playTitleLabelContrainTop,playTitleLabelContrainLeft,playTitleLabelContrainRight,playTitleLabelContrainHeight]
        self.view.addConstraints(playTitleLabelConstraints as! [NSLayoutConstraint])
        playTitleLabel.textAlignment = .Center
        if musicListNameArray.count > 0 {
            playTitleLabel.text = musicListNameArray[0] as? String
        }
        playTitleLabel.text = nil
        // 初始化MusicPlayerView
        self.view.backgroundColor = UIColor.whiteColor()
        musicPlayerView = MusicPlayerView.init(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height - 60, width: UIScreen.mainScreen().bounds.size.width, height: 60))
        self.view.addSubview(musicPlayerView)
        
        // 初始化MusicPlayerListView
        musicPlayerListView = MusicPlayerListView.init(frame: CGRect(x: 0, y: 80, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 150))
        self.view.addSubview(musicPlayerListView)
        musicPlayerListView.playMusicListTableView.delegate = self
        musicPlayerListView.playMusicListTableView.dataSource = self
        
        // 添加MusicPlayerView中控件点击事件
        musicPlayerView.playPauseButton.addTarget(self, action: #selector(handlePlayStatusButtonClick(_:)), forControlEvents: .TouchUpInside)
        musicPlayerView.playNextButton.addTarget(self, action: #selector(handlePlayStatusButtonClick(_:)), forControlEvents: .TouchUpInside)
        musicPlayerView.playPreviousButton.addTarget(self, action: #selector(handlePlayStatusButtonClick(_:)), forControlEvents: .TouchUpInside)
        musicPlayerView.playMenuButton.addTarget(self, action: #selector(handlePlayStatusButtonClick(_:)), forControlEvents: .TouchUpInside)
    }
    
    //MARK: - Public
    
    //MARK: - IBActions
    func handlePlayStatusButtonClick(sender: UIButton) -> Void {
        switch sender {
        case musicPlayerView.playPauseButton:
            if musicListNameArray.count == 0 {
                return
            } else{
                if isPlaying {
                    isPlaying = false
                    musicPlayer.musicPause()
                } else {
                    isPlaying = true
                    musicPlayer.musicPlay()
                }
            }
            break
        case musicPlayerView.playNextButton:
            musicPlayer.musicPlayNext()
            break
        case musicPlayerView.playPreviousButton:
            musicPlayer.musicPlayPrevious()
            break
        case musicPlayerView.playMenuButton:
            musicPlayerListView.playMusicListTableView.hidden = !musicPlayerListView.playMusicListTableView.hidden
            break
        default:
            break
        }
    }
    
    //MARK: - Protocol conformance
    //MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListNameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "cell")
        }
        cell?.selectionStyle = .None
        cell?.textLabel?.text = musicListNameArray[indexPath.row] as? String
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mediaItemCollection = musicPlayerModel.musicMediaItemCollectionWithMediaGrouping(.Title)
        if mediaItemCollection.count > 0 {
            let playingItem = mediaItemCollection.items[indexPath.row] as MPMediaItem
            print(playingItem.valueForProperty(MPMediaItemPropertyTitle))
            musicPlayer.setMediaPlayerWithItemCollection(mediaItemCollection, nowPlayingItem: playingItem)
        }
    }
    
    //MARK: - MusicPlayerDelegate
    func musicPlayer(musicPlayer: MusicPlayer, updatePlaybackCurrentTime currentTime: NSTimeInterval, playbackDurationTime durationTime: NSTimeInterval) {
        musicPlayerView.playProgressBar.progress = Float(currentTime / durationTime)
    }
    
    func musicPlayer(musicPlayer: MusicPlayer, didChangeNowPlayingItem nowPlayingItem: MPMediaItem) {
        playTitleLabel.text = nowPlayingItem.valueForProperty(MPMediaItemPropertyTitle) as? String
    }
    
    func musicPlayer(musicPlayer: MusicPlayer, didChangePlaybackState playbackState: MPMusicPlaybackState) {
        switch playbackState {
        case .Stopped:
            
            break
        case .Playing:
            musicPlayerView.playPauseButton.setBackgroundImage(UIImage(named: "homeMusic-pause"), forState: .Normal)
            break
        case .SeekingForward:
            
            break
        case .SeekingBackward:
            
            break
        case .Paused:
            musicPlayerView.playPauseButton.setBackgroundImage(UIImage(named: "homeMusic-play"), forState: .Normal)
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

