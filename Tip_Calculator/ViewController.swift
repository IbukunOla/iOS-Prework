//
//  ViewController.swift
//  Tip_Calculator
//
//  Created by MacOS on 12/18/17.
//  Copyright © 2017 MacOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var fieldView: UIView!
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!
    
    var tipPercentages = [0.18, 0.2, 0.25]
    let black = UIColor.black
    let white = UIColor.white
    
    let locale = NSLocale.autoupdatingCurrent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // First load
        //Load defaults
        
        //Skin
        let darkSkin = UserDefaults.standard.bool(forKey: "darkSkin")
        changeSkin(darkSkin)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Make text field automatically pop up
        billField.becomeFirstResponder()
        
        //Tip
        let defTip = UserDefaults.standard.double(forKey: "defaultTip")
        //Display it
        if defTip != 0.0 {
            for (index, _) in tipPercentages.enumerated(){
                tipPercentages[index] = defTip + (0.05 * Double(index))
            }
            //change segments
            tipControl.removeAllSegments()
            tipControl.insertSegment(withTitle: String(format: "%.0f%%", tipPercentages[0] * 100), at: 0, animated: true)
            tipControl.insertSegment(withTitle: String(format: "%.0f%%", tipPercentages[1] * 100), at: 1, animated: true)
            tipControl.insertSegment(withTitle: String(format: "%.0f%%", tipPercentages[2] * 100), at: 2, animated: true)
            tipControl.selectedSegmentIndex = 0
            calculateTip((Any).self)
        }
        
        
        //Dark Skin for UI
        let darkSkin = UserDefaults.standard.bool(forKey: "darkSkin")
        changeSkin(darkSkin)
    }
    
    func changeSkin(_ shouldChange: Bool){
        if shouldChange {
            view.backgroundColor = black
            fieldView.backgroundColor = white
            billField.textColor = black
            tipLabel.textColor = white
            totalLabel.textColor = white
            totalTextLabel.textColor = white
            tipTextLabel.textColor = white
        } else {
            view.backgroundColor = white
            fieldView.backgroundColor = black
            billField.textColor = white
            tipLabel.textColor = black
            totalLabel.textColor = black
            totalTextLabel.textColor = black
            tipTextLabel.textColor = black
        }
    }

    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        if sender.accessibilityLabel == "billTR" {
            //If you touch anywhere inside the view for the field go to the billfield
            billField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let currencySymbol = locale.currencySymbol
        
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.alwaysShowsDecimalSeparator = true
        formatter.currencyDecimalSeparator = "."
        formatter.currencyGroupingSeparator = ","
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol
        
        let tipText = formatter.string(for: tip) ?? "0"
        let totalText = formatter.string(for: total) ?? "0."
        
        tipLabel.text = tipText
        totalLabel.text = totalText
    }
    
}

