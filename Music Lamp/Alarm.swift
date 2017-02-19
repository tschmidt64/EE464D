//
//  Alarm.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 2/13/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class Alarm: NSObject, NSCoding {
    //MARK: Types
    struct PropertyKey {
        static let time = "time"
    }
    //MARK: Properties
    var time: Date
    
    //MARK: Archiving Paths
    // Janky force unwrap first element bc apple: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html#//apple_ref/doc/uid/TP40015214-CH14-SW1
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("alarms")
    
    
    init(time: Date) {
        self.time = time
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: PropertyKey.time)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
//        let t = aDecoder.decodeObject(forKey: "name")
//        self.init(time: t!)
//        guard t != nil else {
//            fatalError("Alarm not decoded properly")
//        }
        guard let t = aDecoder.decodeObject(forKey: PropertyKey.time) as? Date else {
            print("Error")
            return nil
        }
        
        self.init(time: t)
    }
}
