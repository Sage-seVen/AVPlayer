//
//  PlayerViewController.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit
import CoreMedia

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        self.view.addGestureRecognizer(gesture)
        preparePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customAVPlayer.playerLayer.frame = videoView.bounds
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer){
        playerControlview.isHidden.toggle()
        isNavigationBarHidden.toggle()
        self.navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: true)
    }
    
    func initializeView(){
        
    }
    
    func preparePlayer(){
        if let playerView = Bundle.main.loadNibNamed("CustomPlayerView", owner: self, options: nil)?.first as? CustomPlayerView {
            //Adding Playerview in Controller
            videoView.addSubview(playerView)
            videoView.frame = playerView.bounds
            customAVPlayer.initPlayer(with: videoToPlay)
            //customAVPlayer.player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
            
            //Adding Player in Playerview
            playerView.videoView.layer.addSublayer(customAVPlayer.playerLayer)
            
            //Assigning variables Objects
            playerView.customAVPlayer = self.customAVPlayer
            self.playerControlview = playerView.controlView
            
            //Adding Time Observers
            //playerView.addTimeObservers()
        }
    }
    

    
}
