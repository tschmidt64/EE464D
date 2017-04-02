//
//  AlarmTableViewCell.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 2/13/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var color: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = "Theme Name Here"
        songNameLabel.text = "Song Name Here"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
