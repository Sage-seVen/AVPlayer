//
//  PlayerViewController.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController{
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var videoSlider: UISlider!
    var videoToPlay: Video!
    var customAVPlayer = CustomAVPlayer()
    var isNavigationBarHidden = false
    var playerControlview : UIView!
    var isPlayerControlViewHidden : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        self.view.addGestureRecognizer(gesture)
        preparePlayer()
        customAVPlayer.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customAVPlayer.removeTimeObservers()
        customAVPlayer.player.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customAVPlayer.playerLayer.frame = videoView.bounds
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer){
        isPlayerControlViewHidden.toggle()
        playerControlview.isHidden = isPlayerControlViewHidden
        isNavigationBarHidden.toggle()
        self.navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: true)
    }
    
    func preparePlayer(){
        if let playerView = Bundle.main.loadNibNamed("CustomPlayerView", owner: self, options: nil)?.first as? CustomPlayerView {
            
            //Adding Playerview in Controller
            videoView.addSubview(playerView)
            videoView.frame = playerView.bounds
            customAVPlayer.initPlayer(with: videoToPlay)
            
            //Adding Player in Playerview
            playerView.videoView.layer.addSublayer(customAVPlayer.playerLayer)
            
            //Assigning variables Objects
            playerView.customAVPlayer = self.customAVPlayer
            self.playerControlview = playerView.controlView
            self.isPlayerControlViewHidden = playerView.isPlayerControlHidden
            
            //Adding Time Observers
            playerView.addTimeObservers()
            
            //Customising Player View Controls
            playerView.hidePlayerControls(afterSeconds: 3)
        }
    }
    
}
