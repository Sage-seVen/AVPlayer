//
//  CustomPlayerView.swift
//  AVPlayer
//
//  Created by Sage_seVen on 13/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit
import CoreMedia

class CustomPlayerView: UIView{

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var videoSlider: UISlider!
    var customAVPlayer = CustomAVPlayer()
    var isVideoPlaying = true
    var isAudioMuted = false
    var isPlayerControlHidden = false
    
    override class func awakeFromNib() {
    }
    
    @IBAction func rewindButtonPressed(_ sender: UIButton) {
        customAVPlayer.rewind()
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        isVideoPlaying.toggle()
        if isVideoPlaying{
            customAVPlayer.play()
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else{
            customAVPlayer.pause()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        customAVPlayer.forward()
    }
    
    @IBAction func muteButtonPressed(_ sender: UIButton) {
        isAudioMuted.toggle()
        customAVPlayer.player.isMuted = isAudioMuted
        if isAudioMuted{
            sender.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        }else{
            sender.setImage(UIImage(systemName: "speaker.2.fill"), for: .normal)
        }
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        customAVPlayer.seekTo(sliderValue: sender.value)
    }
    
    func hidePlayerControls(afterSeconds time:Double){
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.controlView.isHidden = true
            self.isPlayerControlHidden.toggle()
        }
    }
    
    func addTimeObservers(){
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = customAVPlayer.player.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { (CMTime) in
            guard let currentItem = self.customAVPlayer.player.currentItem else {return}
            self.videoSlider.maximumValue = Float(currentItem.duration.seconds)
            self.videoSlider.value = Float(currentItem.currentTime().seconds)
            self.currentTimeLabel.text = self.customAVPlayer.getTimeInString(from: currentItem.currentTime())
            self.totalTimeLabel.text = self.customAVPlayer.getTimeInString(from: currentItem.duration)
        })
    }
    
}
