//
//  ThemesTableViewController.swift
//  Music Lamp
//
//  Created by Taylor Schmidt on 3/27/17.
//  Copyright © 2017 Taylor Schmidt. All rights reserved.
//

import UIKit

class ThemesTableViewController: UITableViewController, AddThemeDelegate {
    
    //MARK: Properties
    
    var themes: [Theme] = []
    let buttonColor = UIColor(colorLiteralRed: 0.996, green: 0.579, blue: 0.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Items
        tableView.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = buttonColor
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "themeCell"
        let row = indexPath.row
        // Add separator to top if there are any cells, else set header to nil
        if themes.count != 0 { addTableViewHeader() }
        else { tableView.tableHeaderView = nil }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ThemeTableViewCell else {
            fatalError("The dequeued cell is not an instance of ThemeTableViewCell.")
        }
        // Configure the cell...
        let theme = themes[row]
        cell.nameLabel.text = theme.themeTitle
        cell.songNameLabel.text = theme.songTitle
        cell.color.text = "\(theme.color)"
        return cell
    }

    internal func addTheme(_ theme: Theme) {
        self.themes.append(theme)
        print("Number of themes: \(themes.count)")
        
        // Persist data
        writeToUserDefaults()

        self.tableView.reloadData()
    }

    
    
    /* Add the separator to the top of the tableView */
    private func addTableViewHeader() {
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        tableView.tableHeaderView = line
        line.backgroundColor = tableView.separatorColor
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete { deleteTheme(at: indexPath) }
    }

    private func deleteTheme(at indexPath: IndexPath) {
        themes.remove(at: indexPath.row)
        // Persist data
        writeToUserDefaults()
        print("Number of alarms: \(themes.count)")
        if themes.isEmpty { tableView.tableHeaderView = nil }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    private func writeToUserDefaults() {
        //        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(alarms, toFile: Alarm.ArchiveURL.path) {
        let success = NSKeyedArchiver.archiveRootObject(themes, toFile: Theme.ArchiveURL.path)
        if success {
            print("Themes successfully saved")
        } else {
            fatalError("Themes save failed")
        }
    }

    private func readFromUserDefaults() -> [Alarm]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Theme.ArchiveURL.path) as? [Alarm]
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
