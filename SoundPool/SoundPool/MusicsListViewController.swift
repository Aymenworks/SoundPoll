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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.musicTableView.tableFooterView = UIView()
        self.musicTableView.tableHeaderView = UIView()
        Facade.sharedInstance().addMusicWithName("From Time", artist: "Drake ft. Jhene Aiko", withMusicThumbnail: UIImage(named: "drake"))
        Facade.sharedInstance().addMusicWithName("Spotless mind", artist: "Jhene Aiko", withMusicThumbnail: UIImage(named: "jhene"))
        Facade.sharedInstance().addMusicWithName("Price Tag", artist: "Jessie J ft. B.o.B", withMusicThumbnail: UIImage(named: "jessiej"))
        
        Facade.sharedInstance().saveMusics()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell!.music = Facade.sharedInstance().musics()[indexPath.row]

        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Facade.sharedInstance().musics().count
    }
}

