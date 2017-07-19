//
//  DVColorLockView.swift
//  Based on DatePickerCell.
//
//  Copyright © 2017 Dylan Vann. All rights reserved.
//

import UIKit

@IBDesignable
class DVColorLockView: UIView {
    
    @IBInspectable
    var lockedBackgroundColor: UIColor {
        set {
            super.backgroundColor = newValue
        }
        get {
            return super.backgroundColor!
        }
    }
    
    override var backgroundColor: UIColor? {
        set {
        }
        get {
            return super.backgroundColor
        }
    }
}

