//
//  VideoTableViewCell.swift
//  AVPlayer
//
//  Created by Sage_seVen on 07/05/20.
//  Copyright © 2020 Sage_seVen. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var recommendedLabelOutlet: UILabel!
    
    @IBOutlet weak var recommendedImageViewOutlet: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
