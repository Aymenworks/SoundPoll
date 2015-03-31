//
//  Facade.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit.UIImage

/**
The Facade pattern. So we can use more easily the complex submodules
that are Location, Network, Data persistency with a sample and reusable API.
*/
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

    /**
    Add a music in our musics list ( an array of musics )
    
    :param: identifier       The identifier of the music. We use it when an user add a notation about a specific music.
    :param: name             The music name
    :param: artist           The music artist
    :param: pictureURL       The url of the music cover image
    :param: numberOfLikes    The number of like added by people
    :param: numberOfDislikes The number of dislike added by people
    */
    public func addMusicWithIdentifier(identifier: String, name: String, artist: String?, pictureURL: String?, numberOfLikes: Int?, numberOfDislikes: Int?) {
        self.persistencyManager.addMusicWithIdentifier(identifier, name: name, artist: artist, pictureURL: pictureURL, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes)
    }
    
    /**
    Add the current music played in the first place of our musics list ( an array of musics )
    
    :param: json The json data describing our music
    */
    public func addCurrentMusicFromJSON(json: JSON) {
        self.persistencyManager.addCurrentMusicFromJSON(json)
    }
    
    /**
    Add the current playlist music ( a list tof music ) in our musics list ( an array of musics )
    
    :param: json The json data describing playlist music
    */
    public func addPlaylistFromJSON(json: JSON) {
        self.persistencyManager.addPlaylistFromJSON(json)
    }
    
    /**
    The list of musics
    
    :returns: The list of musics
    */
    public func musics() -> [Music] {
        return self.persistencyManager.musics
    }
    
    /**
    Save the list of music using the Archiving pattern to preserve class encapsuation concept
    and retrieving data from disk with all musics with theirs properties alredy setted.
    */
    public func saveMusics() {
        self.persistencyManager.saveMusics()
    }
    
    // MARK: - Network -
    
    /**
    Get the current playlist from the server ( hosted by a raspberry pi )
    
    :param: completionHandler The callback containing the playlist that'll be
    executed after the request has finished
    */
    public func playlist(completionHandler: (JSON?, NSError?) -> Void) {
        self.networkManager.playlist(completionHandler)
    }
    
    /**
    Send a start action to the raspberry so it can start the music using loudspeakers
    
    :param: completionHandler The callback that'll be executed after the request has finished
    */
    public func startMusic(completionHandler: (JSON?, NSError?) -> Void) {
        self.networkManager.startMusic(completionHandler)
    }
    
    /**
    Send the notation added by the user about a specific music
    
    :param: musicIdentifier   The music ID
    :param: action            The notation : Like or Dislike
    :param: completionHandler The callback that'll be executed after the request has finished
    */
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
