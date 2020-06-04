//
//  PlayerViewController.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var recommendedTableView: UITableView!
    @IBOutlet weak var videoView: UIView!
    var videos = Video.fetchVideoList()
    var videoToPlay: Video!
    var customAVPlayer = CustomAVPlayer()
    var isNavigationBarHidden = false
    var playerControlview : UIView!
    var isPlayerControlViewHidden : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        self.videoView.addGestureRecognizer(gesture)
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
        //hideNavBar()
    }
    
    func hideNavBar(){
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
