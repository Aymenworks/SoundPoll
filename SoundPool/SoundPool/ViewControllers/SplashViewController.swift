//
//  SplashViewController.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Facade.sharedInstance().playlist { (jsonPlaylist, error) -> Void in
            
            if error == nil && jsonPlaylist != nil && jsonPlaylist!.isOk() {
                
                let currentMusic = jsonPlaylist!["playlist"]["current"]
                let playlist = jsonPlaylist!["playlist"]["following"]
                Facade.sharedInstance().addCurrentMusicFromJSON(currentMusic)
                Facade.sharedInstance().addPlaylistFromJSON(playlist)
                Facade.sharedInstance().fetchMusicsPictures()

            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64((2 * NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("goToMusicsListViewFromSplashView", sender: self)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}