//
//  PlayerViewController+IMAds.swift
//  AVPlayer
//
//  Created by Sage_seVen on 08/06/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit
import GoogleInteractiveMediaAds

extension PlayerViewController: IMAAdsLoaderDelegate, IMAAdsManagerDelegate{
    
    //MARK: - IMAds Integration
    
    func setupContentPlayhead(){
        //inbuiltAVPlayer.playVideo(with: PlayerViewController.ContentURLString)
        contentPlayhead = IMAAVPlayerContentPlayhead(avPlayer: customAVPlayer.player)
        NotificationCenter.default.addObserver(self,selector: #selector(PlayerViewController.contentDidFinishPlaying(_:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: customAVPlayer.player.currentItem);
    }
    
    @objc func contentDidFinishPlaying(_ notification: Notification){
        adsLoader.contentComplete()
    }
    
    func setupAdsLoader(){
        adsLoader = IMAAdsLoader(settings: nil)
        adsLoader.delegate = self
    }
    
    func requestAds(){
        let adDisplayContainer = IMAAdDisplayContainer(adContainer: self.videoView)
        let request =  IMAAdsRequest(adTagUrl: K.AdTagURLString, adDisplayContainer: adDisplayContainer, contentPlayhead: contentPlayhead, userContext: nil)
        adsLoader.requestAds(with: request)
    }
    
    //MARK: - Delegate Methods
    func adsLoader(_ loader: IMAAdsLoader!, adsLoadedWith adsLoadedData: IMAAdsLoadedData!) {
        adsManager = adsLoadedData.adsManager
        adsManager.delegate = self
        adsManager.initialize(with: nil)
        //Checking existing cuepoints
        print(adsManager.adCuePoints!)
    }
    
    func adsLoader(_ loader: IMAAdsLoader!, failedWith adErrorData: IMAAdLoadingErrorData!) {
        print("Error Loading Ads:" + adErrorData.adError.message)
        //need to add show and hide player here
    }
    
    func adsManager(_ adsManager: IMAAdsManager!, didReceive event: IMAAdEvent!) {
        //Play each ad once it has been loaded
        if event.type == IMAAdEventType.LOADED{
            adsManager.start()
        }
    }
    
    func adsManager(_ adsManager: IMAAdsManager!, didReceive error: IMAAdError!) {
        //Fallback to playing content
        customAVPlayer.play()
        print("AdsManager Error:" + error.message)
    }
    
    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager!) {
        customAVPlayer.pause()
        // hide method
    }
    
    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager!) {
        //show method
        customAVPlayer.play()
    }
    
    func addCuePoints(){
        customAVPlayer.player.addBoundaryTimeObserver(forTimes: myAdCuePoints, queue: DispatchQueue.main) {
            print("Cue Condition Check")
            self.playAd()
        }
    }
    
    //Function to play ad on Demand
    func playAd(){
        adsManager.destroy()
        adsLoader.contentComplete()
        requestAds()
        adsManager.start()
    }
}
