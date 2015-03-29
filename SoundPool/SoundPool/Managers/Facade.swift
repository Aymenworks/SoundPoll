//
//  Facade.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit.UIImage

public class Facade {
    
    lazy private var persistencyManager = PersistencyManager()
    lazy private var networkManager = NetworkManager()
    
    /// A singleton object as the entry point to manage the application
    class func sharedInstance() -> Facade {
        struct Singleton {
            static let instance = Facade()
        }
        return Singleton.instance
    }
    
    // MARK: - Lifecycle -
    
    private init() {}
    
    // MARK: - Music persistency -

    public func addMusicWithIdentifier(identifier: String, name: String, artist: String?, pictureURL: String?, numberOfLikes: Int?, numberOfDislikes: Int?) {
        self.persistencyManager.addMusicWithIdentifier(identifier, name: name, artist: artist, pictureURL: pictureURL, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes)
    }
    
    public func addCurrentMusicFromJSON(json: JSON) {
        self.persistencyManager.addCurrentMusicFromJSON(json)
    }
    
    public func addPlaylistFromJSON(json: JSON) {
        self.persistencyManager.addPlaylistFromJSON(json)
    }
    
    public func musics() -> [Music] {
        return self.persistencyManager.musics
    }
    
    public func saveMusics() {
        self.persistencyManager.saveMusics()
    }
    
    // MARK: - Network -
    
    public func playlist(completionHandler: (JSON?, NSError?) -> Void) {
        self.networkManager.playlist(completionHandler)
    }
    
    public func addNotation(musicIdentifier: String, action: String, completionHandler: (JSON?, NSError?) -> Void) {
        self.networkManager.addNotation(musicIdentifier, action: action, completionHandler: completionHandler)
    }
    
    /**
    Will download all the music cover image from their url containted on our array of music
    */
    public func fetchMusicsPictures() {
        self.networkManager.fetchMusicsPictures()
    }
    
    /**
    Will fetch the music cover image
    
    :param: urlImage          The url of the music cover image
    :param: completionHandler The callback containing the music cover image that'll be
    executed after the request has finished
    */
    public func pictureWithURL(urlImage: String, completionHandler: UIImage? -> Void) {
        self.networkManager.pictureWithURL(urlImage, completionHandler: completionHandler)
    }
    


}
