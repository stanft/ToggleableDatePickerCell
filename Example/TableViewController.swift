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

    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! ToggleableDatePickerCell
        
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ToggleableDatePickerCell
        cell.selectedInTableView(tableView)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension TableViewController: ToggleableDatePickerCellDelegate {
    
    func tableNeedsUpdate(for cell: ToggleableDatePickerCell) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
