//
//  Music.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import Foundation
import UIKit.UIImage

public class Music: NSObject {
    
    let name: String!
    let artist: String?
    let thumbnail: UIImage?
    let numberOfLike: Int!
    let numberOfDislike: Int!
    
    init(name: String, artist: String?, withMusicThumbnail thumbnail: UIImage?) {
        super.init()
        self.name = name
        self.artist = artist
        self.thumbnail = thumbnail
        self.numberOfLike = 18
        self.numberOfDislike = 18
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObjectForKey("name") as String
        self.artist = aDecoder.decodeObjectForKey("artist") as? String
        self.numberOfLike = aDecoder.decodeIntegerForKey("numberOfLike")
        self.numberOfDislike = aDecoder.decodeIntegerForKey("numberOfDislike")
        
        if let thumbnailData = aDecoder.decodeObjectForKey("thumbnail") as? NSData {
            self.thumbnail = UIImage(data: thumbnailData)
        }
    }
}

extension Music: NSCoding {
  
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeInteger(self.numberOfLike, forKey: "numberOfLike")
        aCoder.encodeInteger(self.numberOfDislike, forKey: "numberOfDislike")
        
        if self.artist != nil {
            aCoder.encodeObject(self.artist!, forKey: "artist")
        }
        
        if self.thumbnail != nil {
            aCoder.encodeObject(UIImagePNGRepresentation(self.thumbnail!), forKey: "thumbnail")
        }
    }
}

