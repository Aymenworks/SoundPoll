//
//  PersistencyManager.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit.UIImage

class PersistencyManager: NSCoding {
    
    private(set) var musics: [Music]
    
    // MARK: - Lifecycle -
    
    required init(coder aDecoder: NSCoder) {
        self.musics = aDecoder.decodeObjectForKey("musics") as [Music]
    }
    
    init() {
        self.musics = [Music]()
        let fileManager = NSFileManager.defaultManager()
        let documentDirectory = fileManager.URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
        let saveMusicFileUrl = documentDirectory!.URLByAppendingPathComponent("musics.bin")
        
        if let musicsData = NSData(contentsOfURL: saveMusicFileUrl, options:.DataReadingMappedIfSafe, error: nil) {
            if let unarchivedMusics = NSKeyedUnarchiver.unarchiveObjectWithData(musicsData) as? [Music] {
                self.musics = unarchivedMusics
            }
        }
    }
    
    // MARK: - NSCoding delegate -
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.musics, forKey: "musics")
    }
    
    // MARK: - Music persistency -
    
    /**
    Save the list of music using the Archiving pattern to preserve class encapsuation concept
    and retrieving data from disk with all musics with theirs properties alredy setted.
    */
    func saveMusics() {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectory = fileManager.URLForDirectory(.DocumentDirectory, inDomain:.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
        let saveFileUrl = documentDirectory!.URLByAppendingPathComponent("musics.bin")
        
        let musicsData = NSKeyedArchiver.archivedDataWithRootObject(self.musics)
        if musicsData.writeToURL(saveFileUrl, options:.AtomicWrite, error: nil) {
            println("music save succed")
        } else {
            println("music saving")
        }
    }
    
    /**
    Add the current music played in the first place of our musics list ( an array of musics )
    
    :param: json The json data describing our music
    */
    func addCurrentMusicFromJSON(currentMusic: JSON) {
        
        self.musics = []
        
        self.musics.append(Music(identifier: currentMusic["id"].string! , name: currentMusic["name"].string!, artist: currentMusic["artist"].string, pictureURL: currentMusic["img"].string, numberOfLikes: currentMusic["likes"].int, numberOfDislikes: currentMusic["dislikes"].int))
        
        self.saveMusics()
    }
    
    /**
    Add the current playlist music ( a list tof music ) in our musics list ( an array of musics )
    
    :param: json The json data describing playlist music
    */
    func addPlaylistFromJSON(jsonFollowingMusic: JSON) {
        
        for (_, jsonMusic) in jsonFollowingMusic {
            let hasLiked = jsonMusic["hasLiked"].bool
            let hasDisliked = jsonMusic["hasDisliked"].bool

            self.musics.append(Music(identifier: jsonMusic["id"].string! , name: jsonMusic["name"].string!, artist: jsonMusic["artist"].string, pictureURL: jsonMusic["img"].string, numberOfLikes: jsonMusic["likes"].int, numberOfDislikes: jsonMusic["dislikes"].int, likedByMe: hasLiked, dislikedByMe: hasDisliked))
        }
        
        self.saveMusics()
    }
    
    /**
    Add a music in our musics list ( an array of musics )
    
    :param: identifier       The identifier of the music. We use it when an user add a notation about a specific music.
    :param: name             The music name
    :param: artist           The music artist
    :param: pictureURL       The url of the music cover image
    :param: numberOfLikes    The number of like added by people
    :param: numberOfDislikes The number of dislike added by people
    */
    func addMusicWithIdentifier(identifier: String, name: String, artist: String?, pictureURL: String?, numberOfLikes: Int?, numberOfDislikes: Int?) {
        self.musics.append(Music(identifier: identifier, name: name, artist: artist, pictureURL: pictureURL, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes))
    }
}