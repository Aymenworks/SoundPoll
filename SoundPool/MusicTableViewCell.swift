//
//  MusicTableViewCell.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet var musicNameLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var numberOfLike: UILabel!
    @IBOutlet var numberOfDislike: UILabel!
    @IBOutlet var musicThumbnailImage: UIImageView!
    
    var music: Music! {
        didSet {
            self.musicNameLabel.text = music.name
            self.artistLabel.text = music.artist
            self.musicThumbnailImage.image = music.thumbnail
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
