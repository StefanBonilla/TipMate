//
//  SettingsViewController.swift
//  Tipsy
//
//  Created by Bonilla, Stefan on 3/8/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var preferredTipSelector: UISegmentedControl!
    
    @IBOutlet weak var tip1Stepper: UIStepper!
    @IBOutlet weak var tip2Stepper: UIStepper!
    @IBOutlet weak var tip3Stepper: UIStepper!
    
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults.synchronize()
        
        // Set up split switch
        splitSwitch.setOn(defaults.bool(forKey: kSETTINGS_SPLIT), animated: false)
        
        // Set up preferred tip segmented control
        preferredTipSelector.selectedSegmentIndex = defaults.integer(forKey: kSETTINGS_PREFERRED_TIP)
        
        // Set up tip steppers and labels
        tip1Stepper.value = defaults.double(forKey: kSETTINGS_TIP_1)
        tip1Label.text = String(format: "%.0f%%", tip1Stepper.value * 100)
        tip2Stepper.value = defaults.double(forKey: kSETTINGS_TIP_2)
        tip2Label.text = String(format: "%.0f%%", tip2Stepper.value * 100)
        tip3Stepper.value = defaults.double(forKey: kSETTINGS_TIP_3)
        tip3Label.text = String(format: "%.0f%%", tip3Stepper.value * 100)
        
        updateTipSelectorText()
    }
    
    // Updates the text with the corresponding tip percentages
    func updateTipSelectorText() {
        preferredTipSelector.setTitle(String(format: "%.0f%%", defaults.double(forKey: kSETTINGS_TIP_1) * 100), forSegmentAt: 0)
        preferredTipSelector.setTitle(String(format: "%.0f%%", defaults.double(forKey: kSETTINGS_TIP_2) * 100), forSegmentAt: 1)
        preferredTipSelector.setTitle(String(format: "%.0f%%", defaults.double(forKey: kSETTINGS_TIP_3) * 100), forSegmentAt: 2)
    }
    
    @IBAction func enableSplitChanged() {
        defaults.set(splitSwitch.isOn, forKey: kSETTINGS_SPLIT)
        defaults.synchronize()
    }
    
    @IBAction func preferredTipChanged() {
        defaults.set(preferredTipSelector.selectedSegmentIndex, forKey: kSETTINGS_PREFERRED_TIP)
        defaults.synchronize()
    }
    
    @IBAction func tip1Changed() {
        defaults.set(tip1Stepper.value, forKey: kSETTINGS_TIP_1)
        defaults.synchronize()
        tip1Label.text = String(format: "%.0f%%", tip1Stepper.value * 100)
        updateTipSelectorText()
    }
    
    @IBAction func tip2Changed() {
        defaults.set(tip2Stepper.value, forKey: kSETTINGS_TIP_2)
        defaults.synchronize()
        tip2Label.text = String(format: "%.0f%%", tip2Stepper.value * 100)
        updateTipSelectorText()
    }
    
    @IBAction func tip3Changed() {
        defaults.set(tip3Stepper.value, forKey: kSETTINGS_TIP_3)
        defaults.synchronize()
        tip3Label.text = String(format: "%.0f%%", tip3Stepper.value * 100)
        updateTipSelectorText()
    }

}
