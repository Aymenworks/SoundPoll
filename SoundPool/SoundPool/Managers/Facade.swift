//
//  Facade.swift
//  SoundPool
//
//  Created by Rebouh Aymen on 28/03/2015.
//  Copyright (c) 2015 Rebouh Aymen. All rights reserved.
//

import Foundation
import UIKit.UIImage

public class Facade {
    
    private let persistencyManager: PersistencyManager

    /// A singleton object as the entry point to manage the application
    class func sharedInstance() -> Facade {
        struct Singleton {
            static let instance = Facade()
        }
        return Singleton.instance
    }
    
    // MARK: - Lifecycle -
    
    private init() {
        self.persistencyManager = PersistencyManager()
    }
    
    // MARK: - Music persistency -
    
    public func addMusicWithName(name: String, artist: String?, withMusicThumbnail image: UIImage?) {
        self.persistencyManager.addMusicWithName(name, artist: artist, withMusicThumbnail: image)
    }
    
    public func musics() -> [Music] {
        return self.persistencyManager.musics
    }
    
    public func saveMusics() {
        self.persistencyManager.saveMusics()
    }

}
