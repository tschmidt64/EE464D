//
//  FirstViewController.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 1/30/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker
import MediaPlayer

@available(iOS 9.3, *)
class AddThemeViewController: UIViewController {
    
    var selectedColor = UIColor.white
    @IBOutlet weak var colorPicker: SwiftHSVColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.setViewColor(selectedColor)
        
    }
    
    @IBAction func pickSongButtonPressed(_ sender: Any) {
        self.presentPicker(sender)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkForMusicLibraryAccess(andThen f:(()->())? = nil) {
        let status = MPMediaLibrary.authorizationStatus()
        switch status {
        case .authorized:
            f?()
        case .notDetermined:
            MPMediaLibrary.requestAuthorization() { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        f?()
                    }
                }
            }
        case .restricted:
            // do nothing
            break
        case .denied:
            // do nothing, or beg the user to authorize us in Settings
            break
        }
    }
    
    func presentPicker (_ sender: Any) {
        self.checkForMusicLibraryAccess {
            let picker = MPMediaPickerController(mediaTypes:.music)
            picker.delegate = self
            picker.showsCloudItems = false
            picker.prompt = "Pick a song"
            picker.allowsPickingMultipleItems = false
            self.present(picker, animated: true)
            if let pop = picker.popoverPresentationController {
                if let b = sender as? UIBarButtonItem {
                    pop.barButtonItem = b
                }
            }
        }
    }
    
}

protocol AddThemeDelegate {
    func addTheme(_ theme: Theme)
}

@available(iOS 9.3, *)
extension AddThemeViewController : MPMediaPickerControllerDelegate {
    // must implement these, as there is no automatic dismissal
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        /* Trying to get this to work so I can write the song to a file
        guard let song = mediaItemCollection.items.first else { return }
        guard let url = song.assetURL else { return }
        let songAsset = AVURLAsset(url: url)
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let exportFilePathStr = URL(fileURLWithPath: documents).appendingPathComponent("exported.m4a")
        let exporter = AVAssetExportSession(asset: songAsset, presetName: AVAssetExportPresetAppleM4A)
        */
        print("did pick")
        let player = MPMusicPlayerController.applicationMusicPlayer()
        player.setQueue(with:mediaItemCollection)
        self.dismiss(animated:true)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        print("cancel")
        self.dismiss(animated:true)
    }
    
}
