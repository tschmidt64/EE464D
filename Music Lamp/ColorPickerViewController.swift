//
//  FirstViewController.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 1/30/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker
import SwiftHTTP

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
    
    @IBAction func setLightsButtonPressed(_ sender: Any) {
        if let color = colorPicker.color {
            sendLightColorRequest(color: color)
        } else {
            print("ERROR: Couldn't unwrap the color picker's color")
        }
    }
    
    func sendLightColorRequest(color: UIColor) {
        do {
//            the url sent will be https://google.com?hello=world&param2=value2
//            let params = ["hello": "world", "param2": "value2"]
            // IP = 192.168.43.26
            // Make sure that socket calls are one at a time (synchronous), open and close for each call
            let params = ["hello": "world", "param2": "value2"]
            let boundary = "AaB03x"
            let opt = try HTTP.POST("https://google.com", parameters: params)
            print("Request:")
            print("\(opt)")
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
}

