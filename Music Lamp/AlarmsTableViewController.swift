//
//  FirstViewController.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 1/30/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class AlarmsTableViewController: UITableViewController, AddAlarmDelegate {
    //MARK: Properties
    var alarms: [Alarm] = []
    let buttonColor = UIColor(colorLiteralRed: 0.996, green: 0.579, blue: 0.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Items
        tableView.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = buttonColor
        
        // Check NSUserDefaults
        if let savedAlarms = readFromUserDefaults() {
            alarms = savedAlarms
            print("Found alarms in NSUserDefaults")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "alarmCell"
        let row = indexPath.row
        // Add separator to top if there are any cells, else set header to nil
        if alarms.count != 0 { addTableViewHeader() }
        else { tableView.tableHeaderView = nil }
        // Get ahold of cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlarmTableViewCell else {
            fatalError("The dequeued cell is not an instance of AlarmTableViewCell.")
        }
        
        // Get ahold of alarm data at row row
        let alarm = alarms[row]
        cell.alarmTitle.text = "Alarm \(row)"
        let timeFormatter = DateFormatter()
        let amPmFormatter = DateFormatter()
        
        // Format the time and the AM/PM
        timeFormatter.dateFormat = "h:mm"
        amPmFormatter.dateFormat = "a"
        let timeStr = timeFormatter.string(from: alarm.time)
        let amPmStr = amPmFormatter.string(from: alarm.time)
        
        // Apply strings to labels
        cell.timeLabel.text = timeStr
        cell.amPmLabel.text = amPmStr
        
        // Set cell inset to zero if it's the last one, else the standard value
        if row == alarms.count - 1 {
            cell.separatorInset = UIEdgeInsets.zero
        } else {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 0)
        }
        return cell
    }
    
    public func addAlarm(_ alarm: Alarm) {
        self.alarms.append(alarm)
        self.alarms.sort(by: { return $0.time < $1.time })
        print("Number of alarms: \(alarms.count)")
        
        // Persist data
        writeToUserDefaults()
        
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //        super.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
        if editingStyle == .delete {
            deleteAlarm(at: indexPath)
        }
    }
    
    private func deleteAlarm(at indexPath: IndexPath) {
        alarms.remove(at: indexPath.row)
        // Persist data
        writeToUserDefaults()
        print("Number of alarms: \(alarms.count)")
        if alarms.isEmpty { tableView.tableHeaderView = nil }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    /* Add the separator to the top of the tableView */
    private func addTableViewHeader() {
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        tableView.tableHeaderView = line
        line.backgroundColor = tableView.separatorColor
    }
    
    private func writeToUserDefaults() {
        //        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(alarms, toFile: Alarm.ArchiveURL.path) {
        let success = NSKeyedArchiver.archiveRootObject(alarms, toFile: Alarm.ArchiveURL.path)
        if success {
            print("Alarms successfully saved")
        } else {
            fatalError("Alarms save failed")
        }
    }
    
    private func readFromUserDefaults() -> [Alarm]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Alarm.ArchiveURL.path) as? [Alarm]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let segueId = segue.identifier else { fatalError("Couldn't get segueID") }
        switch segueId {
        case "addAlarmSegue":
            let navVC = segue.destination as! UINavigationController
            let destVC = navVC.topViewController as! AddAlarmTableViewController
            destVC.myDelegate = self
        default:
            fatalError("Incorrect switch statement value")
            break
        }
    }
}

