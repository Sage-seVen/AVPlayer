//
//  Video.swift
//  AVPlayer
//
//  Created by Sage_seVen on 07/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import Foundation

struct Video{
    let videoName: String
    let videoFileName: String
    let description : String
    let thumbnailFileName : String
    
    static func fetchVideoList() -> [Video]{
        let v1 = Video(videoName: "Assassin Creed: Valhalla", videoFileName: "video1", description: "Trailer of Assassin Creed: Valhala", thumbnailFileName: "thumbV1")
        let v2 = Video(videoName: "Ghost of Tsushima", videoFileName: "video1", description: "Trailer of Assassin Creed: Valhala", thumbnailFileName: "thumbV2")
        let v3 = Video(videoName: "CyberPunk 2077", videoFileName: "video1", description: "Trailer of Assassin Creed: Valhala", thumbnailFileName: "thumbV3")
        let v4 = Video(videoName: "Last of Us: Part II", videoFileName: "video1", description: "Trailer of Assassin Creed: Valhala", thumbnailFileName: "thumbV4")
        let v5 = Video(videoName: "HORIZON : Zero Dawn", videoFileName: "video1", description: "Trailer of Assassin Creed: Valhala", thumbnailFileName: "thumbV5")
        return [v1, v2, v3, v4, v5]
    }
}
