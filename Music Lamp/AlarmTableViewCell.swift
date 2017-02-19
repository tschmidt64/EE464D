//
//  AlarmTableViewCell.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 2/13/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmTitle: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var amPmLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeLabel.text = "10:30"
        amPmLabel.text = "AM"
        alarmTitle.text = "Title"
        alarmSwitch.setOn(true, animated: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
