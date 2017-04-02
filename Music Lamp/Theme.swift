//
//  Theme.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 2/13/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class Theme: NSObject, NSCoding {
    //MARK: Types
    struct PropertyKey {
        static let themeTitle = "themeTitle"
        static let songTitle = "songTitle"
        static let color = "color"
    }
    //MARK: Properties
    var themeTitle: String
    var songTitle: String
    var color: UIColor

    //MARK: Archiving Paths
    // Janky force unwrap first element bc apple: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html#//apple_ref/doc/uid/TP40015214-CH14-SW1
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("themes")
    
    
    init(themeTitle: String, songTitle: String, color: UIColor) {
        self.themeTitle = themeTitle
        self.songTitle = songTitle
        self.color = color
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(color, forKey: PropertyKey.color)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let color = aDecoder.decodeObject(forKey: PropertyKey.color) as? UIColor else {
            print("ERROR: Could not decode color for theme")
            return nil
        }
        
        guard let songTitle = aDecoder.decodeObject(forKey: PropertyKey.songTitle) as? String else {
            print("ERROR: Could not decode title for theme's song")
            return nil
        }
        
        guard let themeTitle = aDecoder.decodeObject(forKey: PropertyKey.themeTitle) as? String else {
            print("ERROR: Could not decode title for theme")
            return nil
        }
        
        self.init(themeTitle: themeTitle, songTitle: songTitle, color: color)
    }
}
