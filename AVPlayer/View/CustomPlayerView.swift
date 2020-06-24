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
    var totalTimeDurationSeconds = 0.0
    
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
        if(sender.value == 0.5){
            videoSlider.minimumTrackTintColor = .yellow
        }
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
    
    func addCuepointsInSlider(cuepoints: [NSNumber]){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            guard let currentItem = self.customAVPlayer.player.currentItem else {return}
            self.totalTimeDurationSeconds = self.customAVPlayer.getTimeInSeconds(from: currentItem.duration)
            print("Total Video Time is: \(self.totalTimeDurationSeconds) seconds")
            
            for index in 0...cuepoints.count-1 {
                let markerView = UIView()
                markerView.backgroundColor = .yellow
                markerView.translatesAutoresizingMaskIntoConstraints = false
                let sliderWidth = Double(self.videoSlider.frame.width), sliderOrigin = Double(self.videoSlider.frame.origin.x)
                print("Cuepoint:\(Double(exactly: cuepoints[index])!) Width: \(sliderWidth) Origin: \(sliderOrigin)")
                let cuepointXValue = (sliderWidth / self.totalTimeDurationSeconds) * Double(exactly: cuepoints[index])!
                print("CuePointXValue:\(cuepointXValue)")
                markerView.frame = CGRect.init(x: cuepointXValue, y: 14.5, width: 3, height: 3)
                self.videoSlider.addSubview(markerView)
                
                /*
                let thumbRect = self.videoSlider.thumbRect(forBounds: self.videoSlider.bounds, trackRect: self.videoSlider.trackRect(forBounds: self.videoSlider.bounds), value: Float(cuepoints[index]))
                let convertedThumbRect = self.videoSlider.convert(thumbRect, to: self.videoView)
                
                NSLayoutConstraint.activate([
                    markerView.centerXAnchor.constraint(equalTo: self.videoView.leadingAnchor, constant: convertedThumbRect.midX),
                    self.videoSlider.topAnchor.constraint(equalToSystemSpacingBelow: markerView.bottomAnchor, multiplier: 1)
                ])*/
            }
        })
    }
}
