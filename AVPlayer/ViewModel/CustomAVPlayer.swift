//
//  CustomAVPlayer.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import Foundation
import AVFoundation

class CustomAVPlayer{
    var player : AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    func initPlayer(with videoObject: Video){
        let url = Bundle.main.url(forResource: videoObject.videoFileName, withExtension: "mp4")
        player = AVPlayer(url: url!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
    }
    
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func forward(){
        guard let duration = player.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 10.0
        
        if newTime < (CMTimeGetSeconds(duration) - 10.0){
            let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    func rewind(){
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 10.0
        if newTime < 0{
            newTime=0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        player.seek(to: time)
    }
}
