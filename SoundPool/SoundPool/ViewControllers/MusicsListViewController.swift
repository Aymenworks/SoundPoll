//
//  ViewController.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import UIKit

class MusicsListViewController: UIViewController {

    @IBOutlet var musicTableView: UITableView!
    @IBOutlet var currentMusicTitle: UILabel!
    @IBOutlet var currentMusicCoverImage: UIImageView!
    @IBOutlet var currentMusicArtist: UILabel!
    
    // MARK: - Licecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notationAdded:", name: kMusicNotationNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageDownloaded:", name: "DownloadedImageNotification", object: nil)

        self.navigationItem.hidesBackButton = true
        self.musicTableView.tableFooterView = UIView()
        self.musicTableView.tableHeaderView = UIView()
        self.reloadCurrentMusicUI()
        
        NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: "timerReloadData", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kMusicNotationNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "DownloadImageNotification", object: nil)

    }
    
    // MARK: - NSNotification -
    
    func imageDownloaded(notification: NSNotification) {
        println("FINISHED")
        self.musicTableView.reloadData()
        self.reloadCurrentMusicUI()
    }
    
    func notationAdded(notification: NSNotification) {
        Facade.sharedInstance().addNotation(notification.userInfo!["identifier"] as String, action: notification.userInfo!["action"] as String) { (jsonResponse, error) -> Void in
            println("json response  notationAdded= \(jsonResponse)")
            self.refreshMusics(self)
        }
    }
    
    // MARK: - User Interaction -

    
    @IBAction func refreshMusics(sender: AnyObject) {
            BFRadialWaveHUD.showInView(self.navigationController!.view, withMessage: "Mise à jours des musiques..")

        Facade.sharedInstance().playlist { (jsonPlaylist, error) -> Void in
            
            if error == nil && jsonPlaylist != nil && jsonPlaylist!.isOk() {
                
                let playlist = jsonPlaylist!["playlist"]["following"]
                let currentMusic = jsonPlaylist!["playlist"]["current"]
                Facade.sharedInstance().addCurrentMusicFromJSON(currentMusic)
                Facade.sharedInstance().addPlaylistFromJSON(playlist)
                Facade.sharedInstance().fetchMusicsPictures()
                self.musicTableView.reloadData()
                self.reloadCurrentMusicUI()
                self.currentMusicCoverImage.image = Facade.sharedInstance().musics().first?.picture.thumbnail
                BFRadialWaveHUD.sharedInstance().dismiss()
            }
        }
    }
    
    func timerReloadData() {
        
        println("timer reload")
        Facade.sharedInstance().playlist { (jsonPlaylist, error) -> Void in
            
            if error == nil && jsonPlaylist != nil && jsonPlaylist!.isOk() {
                
                let playlist = jsonPlaylist!["playlist"]["following"]
                let currentMusic = jsonPlaylist!["playlist"]["current"]
                Facade.sharedInstance().addCurrentMusicFromJSON(currentMusic)
                Facade.sharedInstance().addPlaylistFromJSON(playlist)
                Facade.sharedInstance().fetchMusicsPictures()
                self.musicTableView.reloadData()
                self.reloadCurrentMusicUI()
            }
        }

    }
    
    @IBAction func startMusic(sender: UIBarButtonItem) {
        Facade.sharedInstance().startMusic { (json, error) -> Void in
            println("json start music = \(json)")
        }
    }
    
    
    // MARK: - User Interface -
    func reloadCurrentMusicUI() {
        if self.currentMusicCoverImage.image != Facade.sharedInstance().musics().first?.picture.thumbnail {
            self.currentMusicCoverImage.image = Facade.sharedInstance().musics().first?.picture.thumbnail
        }
        self.currentMusicTitle.text = Facade.sharedInstance().musics().first?.name
        self.currentMusicArtist.text = Facade.sharedInstance().musics().first?.artist
    }
    
}


// MARK: - UITableView Delegate -

extension MusicsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: MusicTableViewCell?
        cell = tableView.dequeueReusableCellWithIdentifier("MusicCell", forIndexPath: indexPath)  as? MusicTableViewCell
       
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "MusicCell") as? MusicTableViewCell
        }
        
        cell!.music = Facade.sharedInstance().musics()[indexPath.row + 1 < Facade.sharedInstance().musics().count ? indexPath.row+1: indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Facade.sharedInstance().musics().count - 1
    }
}

