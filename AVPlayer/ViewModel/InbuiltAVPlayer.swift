//
//  InbuiltAVPlayer.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import Foundation
import AVKit

protocol PlayerProtocol:UIViewController{}

class InbuiltAVPlayer{
    
    var player = AVPlayer()
    var avPlayerViewController = AVPlayerViewController()
    var delegate: PlayerProtocol?
    
    func playVideo( with videoObject : Video){
        let videoPath = Bundle.main.path(forResource: videoObject.videoFileName, ofType: "mp4")
        let videoURL = URL(fileURLWithPath: videoPath!)
        player = AVPlayer(url: videoURL)
        avPlayerViewController.player = player
        delegate!.present(avPlayerViewController, animated: true, completion: nil)
    }
    
    func playVideo( with linkURL: String){
        let url = URL(string: linkURL)
        player = AVPlayer(url: url!)
        avPlayerViewController.player = player
        delegate!.present(avPlayerViewController, animated: true, completion: nil)
    }
}
