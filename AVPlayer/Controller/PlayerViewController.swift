//
//  PlayerViewController.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var videoSlider: UISlider!
    var videoToPlay: Video!
    var customAVPlayer = CustomAVPlayer()
    var isVideoPlaying = false
    var isAudioMuted = false
    var isNavigationBarHidden = false
    
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
        controlView.isHidden.toggle()
        isNavigationBarHidden.toggle()
        self.navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: true)
    }
    
    func preparePlayer(){
        customAVPlayer.initPlayer(with: videoToPlay)
        videoView.layer.addSublayer(customAVPlayer.playerLayer)
    }
    
    @IBAction func muteButtonPressed(_ sender: UIButton) {
        isAudioMuted.toggle()
        customAVPlayer.player.isMuted = isAudioMuted
        if isAudioMuted{
            sender.setTitle("🔈", for: .normal)
        }else{
            sender.setTitle("🔇", for: .normal)
        }
    }
    
    @IBAction func rewindButtonPressed(_ sender: UIButton) {
        customAVPlayer.rewind()
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        isVideoPlaying.toggle()
        if isVideoPlaying{
            customAVPlayer.play()
            sender.setTitle("⏸", for: .normal)
        }else{
            customAVPlayer.pause()
            sender.setTitle("▶️", for: .normal)
        }
        
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        customAVPlayer.forward()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
    }
}
