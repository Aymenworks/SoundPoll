//
//  MusicTableViewCell.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit

let kMusicNotationNotification = "MusicNotationNotification"

class MusicTableViewCell: UITableViewCell {

    @IBOutlet private var musicNameLabel: UILabel!
    @IBOutlet private var artistLabel: UILabel!
    @IBOutlet private var numberOfLikes: UILabel!
    @IBOutlet private var numberOfDislikes: UILabel!
    @IBOutlet private var musicThumbnailImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dislikeButton: UIButton!
    
    var music: Music! {
        didSet {
            println("music cell = \(music) ")
            self.musicNameLabel.text = music.name
            self.artistLabel.text = music.artist
            self.numberOfLikes.text = String(self.music.numberOfLikes!)
            self.numberOfDislikes.text = String(self.music.numberOfDislikes!)

            if music.picture.thumbnail != nil {
                self.musicThumbnailImage.image = music.picture.thumbnail
            }
            
            if music.picture.url == nil {
                self.musicThumbnailImage.image = UIImage(named: "music")
            }
            
        }
    }
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    // MARK: - User Interaction -

    @IBAction func didClickOnLikeButton() {
        self.likeButton.enabled = false
        self.music.numberOfLikes!++
        self.numberOfLikes!.text = String(self.music.numberOfLikes!)
        NSNotificationCenter.defaultCenter().postNotificationName(kMusicNotationNotification, object: self, userInfo: ["identifier": music.identifier!, "action": "like"])
    }
    
    @IBAction func didClickOnDislikeButton() {
        self.dislikeButton.enabled = false
        self.music.numberOfDislikes!++
        self.numberOfDislikes.text = String(self.music.numberOfDislikes!)
        NSNotificationCenter.defaultCenter().postNotificationName(kMusicNotationNotification, object: self, userInfo: ["identifier": music.identifier!, "action": "dislike"])
    }
    
}
