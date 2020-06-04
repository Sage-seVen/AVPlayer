//
//  PlayerViewController+RecommendedTableView.swift
//  AVPlayer
//
//  Created by Sage_seVen on 28/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit

// This extension is to add Recommended TableView Functionality

extension PlayerViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendedTableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.recommendedLabelOutlet.text = videos[videos.count-indexPath.row-1].videoName
        cell.recommendedImageViewOutlet.image = UIImage(named: videos[videos.count-indexPath.row-1].thumbnailFileName)
        return cell
    }
    
    //Header Functionality
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 10, y: 10, width: recommendedTableView.frame.width, height: 50))

        let label1 = UILabel()
        label1.frame = CGRect.init(x: 10, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label1.text = "\(videoToPlay.videoName) Official Trailer"
        label1.numberOfLines = 0
        label1.textColor = .blue
        label1.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        let label2 = UILabel()
        label2.frame = CGRect.init(x: 50, y: 50, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label2.text = "Like 👍🏼\t\t Dislike 👎🏻\t\t Download ⬇️ "
        label2.numberOfLines = 0
        label2.font = UIFont.boldSystemFont(ofSize: 17.0)
        
        self.recommendedTableView.tableHeaderView = headerView;
        headerView.addSubview(label1)
        headerView.addSubview(label2)
        return headerView
    }
    
    //DidSelectRow At
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Recommended Video Selected : \(indexPath.row)")
        let selectedVideo = videos[videos.count-indexPath.row-1]
        let playerVC = self.storyboard?.instantiateViewController(identifier: "playerVC") as! PlayerViewController
        playerVC.videoToPlay = selectedVideo
        self.navigationController?.pushViewController(playerVC, animated: true)
    }
}
