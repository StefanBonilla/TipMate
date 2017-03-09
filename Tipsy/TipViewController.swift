//
//  ViewController.swift
//  Tipsy
//
//  Created by Bonilla, Stefan on 3/8/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var splitLabel: UILabel!
    
    let tipAmounts = [0.10, 0.15, 0.20]

    override func viewDidLoad() {
        super.viewDidLoad()
        splitStepper.value = 1;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        billTextField.becomeFirstResponder()
        splitLabel.text = String(format: "%.0f", splitStepper.value)
        
        for (index, tipAmount) in tipAmounts.enumerated() {
            tipSelector.setTitle(String(format: "%.0f%%", tipAmount * 100), forSegmentAt: index)
        }
    }
    
    @IBAction func calculate() {
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * tipAmounts[tipSelector.selectedSegmentIndex]
        
        splitLabel.text = String(format: "%.0f", splitStepper.value)
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", (bill + tip) / splitStepper.value)
    }

}

