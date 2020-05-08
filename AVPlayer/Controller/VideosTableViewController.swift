//
//  VideosTableViewController.swift
//  AVPlayer
//
//  Created by Sage_seVen on 07/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideosTableViewController: UITableViewController , PlayerProtocol{
    
    var videos = Video.fetchVideoList()
    var inbuiltAVPlayer = InbuiltAVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inbuiltAVPlayer.delegate=self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.videoNameLabel.text = videos[indexPath.row].videoName
        cell.thumbnailImageView.image = UIImage(named: videos[indexPath.row].thumbnailFileName)
        return cell
    }
    
    //MARK: - Table View Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row is : \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedVideo = videos[indexPath.row]
        
        //Method 1: To play with Inbuilt AVPlayer Uncomment this Block
        //inbuiltAVPlayer.playVideo(with: selectedVideo)
        
        //Method 2: To Play with external Video URL
        //inbuiltAVPlayer.playVideo(with: "")
        
        //Method 3: To Play with Custom AVPlayer, Uncomment this block
        let playerVC = self.storyboard?.instantiateViewController(identifier: "playerVC") as! PlayerViewController
        playerVC.videoToPlay = selectedVideo
        self.navigationController?.pushViewController(playerVC, animated: true)
    }
}
