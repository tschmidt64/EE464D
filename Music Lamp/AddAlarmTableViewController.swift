//
//  AddAlarmTableViewController.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 2/13/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class AddAlarmTableViewController: UITableViewController {

    var myDelegate: AddAlarmDelegate?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatPicker()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        saveAlarm()
        self.dismiss(animated: true, completion: nil)
    }
    
    /* Save input data */
    private func saveAlarm() {
        let time = self.timePicker.date
        guard let del = myDelegate else { fatalError("Could not create delegate") }
        del.addAlarm(Alarm(time: time))
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func formatPicker() {
        // Set font color
        timePicker.setValue(UIColor.white, forKey: "textColor")
        // Perform jank-ass divider color change because Apple is death
        if let pickerView = timePicker.subviews.first {
            for subview in pickerView.subviews {
                if subview.frame.height <= 5 {
                    subview.backgroundColor = UIColor.gray
                    subview.tintColor = UIColor.gray
                    subview.layer.borderColor = UIColor.gray.cgColor
                    subview.layer.borderWidth = 0.5
                }
            }
        }
    }
}

protocol AddAlarmDelegate {
    func addAlarm(_ alarm: Alarm)
}
