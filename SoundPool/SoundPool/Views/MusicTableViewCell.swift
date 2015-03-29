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
            self.musicNameLabel.text = music.name
            self.artistLabel.text = music.artist
            self.numberOfLikes.text = String(self.music.numberOfLikes!)
            self.numberOfDislikes.text = String(self.music.numberOfDislikes!)
            
            self.toggleLike()
            
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
        
        var action = ""

        if self.music.likedByMe {
            self.music.numberOfLikes!--
            action = "unlike"

        } else {
            self.music.numberOfLikes!++
            action = "like"
        }
        
        self.music.likedByMe = !self.music.likedByMe
        self.toggleLike()
        self.numberOfLikes!.text = String(self.music.numberOfLikes!)
        NSNotificationCenter.defaultCenter().postNotificationName(kMusicNotationNotification, object: self, userInfo: ["identifier": music.identifier!, "action": action])
    }
    
    @IBAction func didClickOnDislikeButton() {
        
        var action = ""
        if music.dislikedByMe {
            self.music.numberOfDislikes!--
            action = "undislike"
        } else {
            self.music.numberOfDislikes!++
            action = "dislike"
        }
        
        self.music.dislikedByMe = !self.music.dislikedByMe
        self.toggleLike()
        self.numberOfDislikes.text = String(self.music.numberOfDislikes!)
        NSNotificationCenter.defaultCenter().postNotificationName(kMusicNotationNotification, object: self, userInfo: ["identifier": music.identifier!, "action": action])
    }
    
    // MARK: - User Interface -
    
    
    func toggleLike() {
        if self.music.likedByMe {
            self.likeButton.setImage(UIImage(named: "close"), forState: .Normal)
        } else {
            self.likeButton.setImage(UIImage(named: "like"), forState: .Normal)
        }
        
        if self.music.dislikedByMe {
            self.dislikeButton.setImage(UIImage(named: "close"), forState: .Normal)
        } else {
            self.dislikeButton.setImage(UIImage(named: "dislike"), forState: .Normal)
        }
    }
    

    
}
