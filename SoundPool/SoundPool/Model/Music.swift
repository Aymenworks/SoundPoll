//
//  Music.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit.UIImage

public class Music: NSObject {
    
    let identifier: String!
    let name: String!
    let artist: String?
    var picture: (url: String?, thumbnail: UIImage?) {
        didSet {
            if picture.url == nil {
                self.picture.thumbnail = nil
            }
        }
    }
    var numberOfLikes: Int!
    var numberOfDislikes: Int!
    
    init(identifier: String, name: String, artist: String?, pictureURL: String?, numberOfLikes: Int?, numberOfDislikes: Int?) {
        super.init()
        self.identifier = identifier
        self.name = name
        self.artist = artist
        self.picture.url = pictureURL
        self.numberOfLikes = numberOfLikes == nil ? 0 : numberOfLikes!
        self.numberOfDislikes = numberOfDislikes == nil ? 0 : numberOfDislikes!
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
        self.identifier = aDecoder.decodeObjectForKey("identifier") as String
        self.name = aDecoder.decodeObjectForKey("name") as String
        self.artist = aDecoder.decodeObjectForKey("artist") as? String
        self.numberOfLikes = aDecoder.decodeIntegerForKey("numberOfLike")
        self.numberOfDislikes = aDecoder.decodeIntegerForKey("numberOfDislike")
        
        if let thumbnailData = aDecoder.decodeObjectForKey("thumbnail") as? NSData {
            self.picture.thumbnail = UIImage(data: thumbnailData)
        }
    }
}

extension Music: NSCoding {
  
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.identifier, forKey: "identifier")
        aCoder.encodeObject(self.name, forKey: "name")
        
        aCoder.encodeInteger(self.numberOfLikes!, forKey: "numberOfLike")
        aCoder.encodeInteger(self.numberOfDislikes!, forKey: "numberOfDislike")
        
        if self.artist != nil {
            aCoder.encodeObject(self.artist!, forKey: "artist")
        }
        
        if self.picture.thumbnail != nil {
            aCoder.encodeObject(UIImagePNGRepresentation(self.picture.thumbnail!), forKey: "thumbnail")
        }
    }
}

extension Music: Printable {
    override public var description: String {
        return "name = \(self.name), pictureUrl = \(self.picture.url) and numberOfDislikes = \(self.numberOfDislikes)"
    }
}
