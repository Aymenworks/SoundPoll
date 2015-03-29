//
//  NetworkManager.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import Foundation.NSError
import UIKit.UIImage

/**
The authentication network manager. It take care of the http request to like/dislike a music, 
get the playlist from the server, etc..
*/
class NetworkManager {
    
    /**
    <#Description#>
    
    :param: musicIdentifier   <#musicIdentifier description#>
    :param: action            <#action description#>
    :param: completionHandler <#completionHandler description#>
    */
    func addNotation(musicIdentifier: String, action: String, completionHandler: (JSON?, NSError?) -> Void) {
        request(.PUT, "http://192.168.3.24:3000/\(action)/\(musicIdentifier)")
            .validate()
            .responseSwiftyJSON { ( request, _, jsonResponse, error) in
                println("request = \(request)")
                completionHandler(jsonResponse, error)
        }
    }
    
    /**
    <#Description#>
    
    :param: completionHandler <#completionHandler description#>
    */
    func playlist(completionHandler: (JSON?, NSError?) -> Void) {
        request(.GET, "http://192.168.3.24:3000/playlist")
            .validate()
            .responseSwiftyJSON { (_, _, jsonResponse, error) in
                completionHandler(jsonResponse, error)
        }
    }
    
    func startMusic(completionHandler: (JSON?, NSError?) -> Void) {
        request(.GET, "http://192.168.3.24:3000/launch")
            .validate()
            .responseSwiftyJSON { (_, _, jsonResponse, error) in
                completionHandler(jsonResponse, error)
        }
    }
    
    /**
    <#Description#>
    */
    func fetchMusicsPictures() {
        
        var numberOfImagesToDownload = Facade.sharedInstance().musics().count
        var numberOfImagesDownloaded = 0

        for music in Facade.sharedInstance().musics() {
            if let pictureUrl = music.picture.url {
                Facade.sharedInstance().pictureWithURL(pictureUrl) { image -> Void in
                    music.picture.thumbnail = image
                    numberOfImagesDownloaded++
                    // If we have downloaded all the pictures, we save it.
                    if numberOfImagesDownloaded == numberOfImagesToDownload {
                        Facade.sharedInstance().saveMusics()
                        NSNotificationCenter.defaultCenter().postNotificationName("DownloadedImageNotification", object: nil)
                    }
                }
            } else {
                numberOfImagesDownloaded++
                music.picture.thumbnail = nil
                // If we have downloaded all the pictures, we save it.
                if numberOfImagesDownloaded == numberOfImagesToDownload {
                    Facade.sharedInstance().saveMusics()
                    NSNotificationCenter.defaultCenter().postNotificationName("DownloadedImageNotification", object: nil)
                }
            }
        }
    }
    
    
    /**
    Will fetch the music cover image
    
    :param: urlImage          The url of the music cover image
    :param: completionHandler The callback containing the music cover image that'll be executed after the request has finished
    */
    func pictureWithURL(urlImage: String, completionHandler: (UIImage?) -> Void) {
        request(.GET, urlImage)
            .validate()
            .responseImage { (_, _, image, _) -> Void in
                completionHandler(image)
        }
    }
}