//
//  MusicPlayer.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

/**
 *  MusicPlayer Delegate
 */
protocol MusicPlayerDelegate : NSObjectProtocol {
    /**
     更新播放进度
     
     - parameter musicPlayer:  MusicPlayer
     - parameter currentTime:  当前播放时间
     - parameter durationTime: 播放总时长
     */
    func musicPlayer(musicPlayer: MusicPlayer, updatePlaybackCurrentTime currentTime: NSTimeInterval, playbackDurationTime durationTime: NSTimeInterval)
    /**
     更新播放状态
     
     - parameter musicPlayer:   MusicPlayer
     - parameter playbackState: 播放状态(播放，暂停，停止等)
     */
    func musicPlayer(musicPlayer: MusicPlayer, didChangePlaybackState playbackState: MPMusicPlaybackState)
    /**
     更新播放Item
     
     - parameter musicPlayer:    MusicPlayer
     - parameter nowPlayingItem: 正在播放的Item
     */
    func musicPlayer(musicPlayer: MusicPlayer, didChangeNowPlayingItem nowPlayingItem: MPMediaItem)
}

/// 音乐播放器 类
class MusicPlayer: NSObject {
    //MARK: - Properties
    private var audioPlayer: AVAudioPlayer
    private var musicPlayer: MPMusicPlayerController
    var musicShuffleMode: MPMusicShuffleMode
    var musicRepeatMode: MPMusicRepeatMode
    var timer: NSTimer!
    var musicPlayerModel: MusicPlayerModel!
    
    var playinMediaItem: MPMediaItem {
        return musicPlayer.nowPlayingItem!
    }
    
    weak var delegate: MusicPlayerDelegate?
    
    //MARK: - LifeCycle
    override init() {
        self.musicPlayer = MPMusicPlayerController.systemMusicPlayer()
        self.audioPlayer = AVAudioPlayer.init()
        self.musicShuffleMode = .Off
        self.musicRepeatMode = .Default
        
        super.init()
        
        self.initMusicPlayer()
        registerMediaPlayerNotifications()
    }
    
    //MARK: - Custom Accessors
    func registerMediaPlayerNotifications() {
        let notification = NSNotificationCenter.defaultCenter()
        notification.addObserver(self, selector: #selector(handleNowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: musicPlayer)
        notification.addObserver(self, selector: #selector(handlePlaybackStateChanged(_:)), name: MPMusicPlayerControllerPlaybackStateDidChangeNotification, object: musicPlayer)
        musicPlayer.beginGeneratingPlaybackNotifications()
    }
    
    //MARK: - IBActions
    
    //MARK: - NotificationHandlers
    func handleNowPlayingItemChanged(Notification: NSNotification) {
        delegate?.musicPlayer(self, didChangeNowPlayingItem: playinMediaItem)
    }
    
    func handlePlaybackStateChanged(Notification: NSNotification) {
        delegate?.musicPlayer(self, didChangePlaybackState: musicPlayer.playbackState)
    }
    
    //MARK: - Public
    /**
     播放音乐
     */
    func musicPlay() {
        musicPlayer.play()
    }
    
    /**
     暂停音乐
     */
    func musicPause() {
        musicPlayer.pause()
    }
    
    /**
     播放下一曲
     */
    func musicPlayNext() {
        let mediaItemCollection = musicPlayerModel.musicMediaItemCollectionWithMediaGrouping(.Title)
        if musicPlayer.indexOfNowPlayingItem == mediaItemCollection.count - 1 {
            return
        } else {
            musicPlayer.skipToNextItem()
        }
    }
    
    /**
     播放前一曲
     */
    func musicPlayPrevious() {
        let mediaItemCollection = musicPlayerModel.musicMediaItemCollectionWithMediaGrouping(.Title)
        if musicPlayer.indexOfNowPlayingItem <= 0 || musicPlayer.indexOfNowPlayingItem > mediaItemCollection.count {
            return
        } else {
            musicPlayer.skipToPreviousItem()
        }
    }
    
    /**
     设置播放内容
     
     - parameter itemCollection: 播放列表
     - parameter playingItem:    播放Item
     
     - returns: true，成功 false，失败
     */
    func setMediaPlayerWithItemCollection(itemCollection: MPMediaItemCollection?, nowPlayingItem playingItem: MPMediaItem?) -> Bool {
        
        if (itemCollection!.count == 0) && (playingItem == nil) {
            return false
        }
        
        if musicPlayer.playbackState == .Playing {
            musicPlayer.pause()
        }
        
        if itemCollection != nil {
            musicPlayer.setQueueWithItemCollection(itemCollection!)
        }
        musicPlayer.nowPlayingItem = playingItem
//        musicPlayer.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        return true
    }
    
    //MARK: - Private
    private func initMusicPlayer() {
        if musicPlayer.playbackState == .Playing {
            musicPlayer.stop()
        }
        musicPlayer.shuffleMode = musicShuffleMode
        musicPlayer.repeatMode  = musicRepeatMode
        musicPlayerModel = MusicPlayerModel.init()
    }
    
    func updateTime() {
        delegate?.musicPlayer(self, updatePlaybackCurrentTime: musicPlayer.currentPlaybackTime, playbackDurationTime: (musicPlayer.nowPlayingItem?.playbackDuration)!)
    }
    
    //MARK: - Protocol conformance
}
