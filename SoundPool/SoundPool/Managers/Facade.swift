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
    <#Description#>
    
    :param: identifier       <#identifier description#>
    :param: name             <#name description#>
    :param: artist           <#artist description#>
    :param: pictureURL       <#pictureURL description#>
    :param: numberOfLikes    <#numberOfLikes description#>
    :param: numberOfDislikes <#numberOfDislikes description#>
    */
    public func addMusicWithIdentifier(identifier: String, name: String, artist: String?, pictureURL: String?, numberOfLikes: Int?, numberOfDislikes: Int?) {
        self.persistencyManager.addMusicWithIdentifier(identifier, name: name, artist: artist, pictureURL: pictureURL, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes)
    }
    
    /**
    <#Description#>
    
    :param: json <#json description#>
    */
    public func addCurrentMusicFromJSON(json: JSON) {
        self.persistencyManager.addCurrentMusicFromJSON(json)
    }
    
    /**
    <#Description#>
    
    :param: json <#json description#>
    */
    public func addPlaylistFromJSON(json: JSON) {
        self.persistencyManager.addPlaylistFromJSON(json)
    }
    
    /**
    <#Description#>
    
    :returns: <#return value description#>
    */
    public func musics() -> [Music] {
        return self.persistencyManager.musics
    }
    
    /**
    <#Description#>
    */
    public func saveMusics() {
        self.persistencyManager.saveMusics()
    }
    
    // MARK: - Network -
    
    /**
    <#Description#>
    
    :param: completionHandler <#completionHandler description#>
    */
    public func playlist(completionHandler: (JSON?, NSError?) -> Void) {
        self.networkManager.playlist(completionHandler)
    }
    
    public func startMusic(completionHandler: (JSON?, NSError?) -> Void) {
        self.networkManager.startMusic(completionHandler)
    }
    
    /**
    <#Description#>
    
    :param: musicIdentifier   <#musicIdentifier description#>
    :param: action            <#action description#>
    :param: completionHandler <#completionHandler description#>
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
