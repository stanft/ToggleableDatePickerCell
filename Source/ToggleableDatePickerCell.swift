//
//  ToggeableDatePickerCell.swift
//  ToggeableDatePickerCell
//
//  Created by Stephan Anft on 19.07.17.
//  Copyright © 2017 Lufthansa Industry Solutions. All rights reserved.
//  Based on DatePickerCell by Dylan Vann. All rights reserved.
//

import Foundation
import UIKit

/**
*  Inline/Expanding date picker for table views.
*/

/**
 *  Optional protocol called when date is picked
 */

@objc public protocol ToggleableDatePickerCellDelegate {

    @objc optional func toggleableDatePickerCell(_ cell: ToggleableDatePickerCell, didPickDate date: Date?)

    func tableNeedsUpdate(for cell: ToggleableDatePickerCell)

}

open class ToggleableDatePickerCell: UITableViewCell {

    @IBOutlet public weak var leftLabel: UILabel!
    @IBOutlet public weak var rightLabel: UILabel!
    @IBOutlet public weak var togglerLabel: UILabel!
    @IBOutlet private var togglerSwitch: UISwitch!
    @IBOutlet public var datePicker: UIDatePicker!

    @IBOutlet private weak var separatorView: DVColorLockView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var togglerView: UIView!
    @IBOutlet private weak var datePickerView: UIView!

    /// The cell's delegate.
    public var delegate: ToggleableDatePickerCellDelegate?

    // Only create one NSDateFormatter to save resources.
    static let dateFormatter = DateFormatter()

    /// The selected date, set to current date/time on initialization.
    public var date: Date? {
        didSet {
            dateActive = date != nil
            performUIChangesForDate()
        }
    }

    /// The time style.
    public var timeStyle = DateFormatter.Style.short {
        didSet {
            ToggleableDatePickerCell.dateFormatter.timeStyle = timeStyle
            performUIChangesForDate()
        }
    }

    /// The date style.
    public var dateStyle = DateFormatter.Style.medium {
        didSet {
            ToggleableDatePickerCell.dateFormatter.dateStyle = dateStyle
            performUIChangesForDate()
        }
    }

    /// Color of the right label. Default is the color of a normal detail label.
    open var rightLabelTextColor = UIColor(hue: 0.639, saturation: 0.041, brightness: 0.576, alpha: 1.0) {
        didSet {
            rightLabel.textColor = rightLabelTextColor
        }
    }

    /// Indicates whether the date picker cell is currently expanded or collapsed.
    public var expanded = false

    /// Indicates whether the date value is currently active (not `nil`) or inactive (`nil`).
    public var dateActive: Bool {
        get {
            return togglerSwitch.isOn
        }
        set {
            togglerSwitch.isOn = newValue
//            updateUIForToggler()
        }
    }

// MARK: Initializing

    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        // Load content view from NIB
        let bundle = Bundle(for: ToggleableDatePickerCell.self)
        let cellContentView = bundle.loadNibNamed("ToggleableDatePickerCell", owner: self, options: nil)![0] as! UIView

        // Set content view
        self.contentView.addSubview(cellContentView)
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", metrics: nil, views: ["view": cellContentView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", metrics: nil, views: ["view": cellContentView]))

        // Set some visualization attributes
        rightLabel.textColor = rightLabelTextColor

        // Set initial view state
        ToggleableDatePickerCell.dateFormatter.dateStyle = dateStyle
        ToggleableDatePickerCell.dateFormatter.timeStyle = timeStyle
        expanded = false
        dateActive = false
        performUIChangesForTogglerSwitch()
        // Required to ensure smooth animation
        togglerLabel.isHidden = true
        togglerSwitch.isHidden = true
    }

// MARK: Actions

    @IBAction func togglerSwitched(_ sender: UISwitch) {
        if dateActive {
            date = datePicker.date
        } else {
            date = nil
        }
        performUIChangesForTogglerSwitch()
    }

    @IBAction func datePicked(_ sender: UIDatePicker) {
        date = dateActive ? datePicker.date : nil
        self.delegate?.toggleableDatePickerCell?(self, didPickDate: date)
    }

// MARK: Internal functions

    private func performUIChangesForTogglerSwitch() {
        updateVisibilityOfElements()
        performUIChangesForDate()
        delegate?.tableNeedsUpdate(for: self)
    }

    private func performUIChangesForDate() {
        if let date = date {
            datePicker.date = date
            rightLabel.text = ToggleableDatePickerCell.dateFormatter.string(from: date)
        } else {
            rightLabel.text = nil
        }
    }

    private func updateVisibilityOfElements() {
        separatorView.isHidden = !expanded
        togglerView.isHidden = !expanded
        datePickerView.isHidden = !expanded || !dateActive
    }

    private func animateViewChanges() {
        func performTransition() {
            UIView.transition(with: self.togglerView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.togglerSwitch.isHidden = !self.expanded
                self.togglerLabel.isHidden = !self.expanded
            })
            UIView.transition(with: rightLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
                self.rightLabel.textColor = self.expanded ? self.tintColor : self.rightLabelTextColor
            })
        }

        if !dateActive && expanded {
            // Delay animate if cell will expand and toggler is off (because of low height)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                performTransition()
            }
        } else {
            performTransition()
        }
    }

    /**
    Used to notify the DatePickerCell that it was selected. The DatePickerCell will then run its selection animation and expand or collapse.
    - parameter tableView: The table view the DatePickerCell was selected in.
    */
    open func selectedInTableView(_ tableView: UITableView) {
        expanded = !expanded
        animateViewChanges()
        updateVisibilityOfElements()
        delegate?.tableNeedsUpdate(for: self)
    }

    // Action for the datePicker ValueChanged event.
//    func datePicked() {
//        date = datePicker.date
//        // date picked, call delegate method
//        self.delegate?.datePickerCell?(self, didPickDate: date)
//    }
}
