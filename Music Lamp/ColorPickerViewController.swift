//
//  FirstViewController.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 1/30/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class ColorPickerViewController: UIViewController {
    
    var selectedColor = UIColor.white
    @IBOutlet weak var colorPicker: SwiftHSVColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.setViewColor(selectedColor)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

