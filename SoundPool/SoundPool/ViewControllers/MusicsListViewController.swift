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
    
    // MARK: - Licecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notationAdded:", name: kMusicNotationNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "imageDownloaded:", name: "DownloadedImageNotification", object: nil)

        self.musicTableView.tableFooterView = UIView()
        self.musicTableView.tableHeaderView = UIView()
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
    }
    
    func notationAdded(notification: NSNotification) {
        println("received = \(notification.userInfo)")
    }
    
    // MARK: - User Interaction -

    @IBAction func refreshMusics(sender: UIBarButtonItem) {
        Facade.sharedInstance().playlist { (jsonPlaylist, error) -> Void in
            
            if error == nil && jsonPlaylist != nil && jsonPlaylist!.isOk() {
                
                println("jsonPlaylist aymen = \(jsonPlaylist)")
                let playlist = jsonPlaylist!["playlist"]["following"]
                Facade.sharedInstance().addPlaylistFromJSON(playlist)
                Facade.sharedInstance().fetchMusicsPictures()
            }
        }
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
        
        println("cellForRowAtIndexPath pourtant count == \(Facade.sharedInstance().musics().count)")

        cell!.music = Facade.sharedInstance().musics()[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Facade.sharedInstance().musics().count
    }
}

