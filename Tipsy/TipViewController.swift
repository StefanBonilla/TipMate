//
//  ViewController.swift
//  Tipsy
//
//  Created by Bonilla, Stefan on 3/8/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitView: UIView!
    
    var tipAmounts: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        splitStepper.value = 1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults.synchronize()
        
        // Configure tip selector
        tipAmounts = []
        tipSelector.selectedSegmentIndex = defaults.integer(forKey: kSETTINGS_PREFERRED_TIP)
        tipAmounts.append(defaults.double(forKey: kSETTINGS_TIP_1))
        tipAmounts.append(defaults.double(forKey: kSETTINGS_TIP_2))
        tipAmounts.append(defaults.double(forKey: kSETTINGS_TIP_3))
        tipSelector.setTitle(String(format: "%.0f%%", tipAmounts[0] * 100), forSegmentAt: 0)
        tipSelector.setTitle(String(format: "%.0f%%", tipAmounts[1] * 100), forSegmentAt: 1)
        tipSelector.setTitle(String(format: "%.0f%%", tipAmounts[2] * 100), forSegmentAt: 2)
        
        // Check if the split feature is enabled
        if !defaults.bool(forKey: kSETTINGS_SPLIT) {
            splitView.isHidden = true
        } else {
            splitView.isHidden = false
            splitLabel.text = String(format: "%.0f", splitStepper.value)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        billTextField.becomeFirstResponder()
    }
    
    @IBAction func calculate() {
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * tipAmounts[tipSelector.selectedSegmentIndex]
        
        splitLabel.text = String(format: "%.0f", splitStepper.value)
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", (bill + tip) / splitStepper.value)
    }

}

