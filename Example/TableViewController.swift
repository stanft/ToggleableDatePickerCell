//
//  TableViewController.swift
//  ToggleableDatePickerExample
//
//  Created by Stephan Anft on 24.07.17.
//  Copyright © 2017 Lufthansa Industry Solutions. All rights reserved.
//

import UIKit
import ToggleableDatePickerCell

class TableViewController: UITableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! ToggleableDatePickerCell
        
        // Configure the cell...

        return cell
    }
    
}
