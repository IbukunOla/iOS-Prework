//
//  SettingsViewController.swift
//  Tip_Calculator
//
//  Created by MacOS on 12/23/17.
//  Copyright © 2017 MacOS. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var DTLabel: UILabel!
    @IBOutlet weak var dsLabel: UILabel!
    @IBOutlet weak var defaultTip: UITextField!
    @IBOutlet weak var dsSwitch: UISwitch!
    
    let black = UIColor.black
    let white = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init Load
         self.title = "Tip Calculator"
        let darkSkin = UserDefaults.standard.bool(forKey: "darkSkin")
        changeSkin(darkSkin)
        dsSwitch.setOn(darkSkin, animated: true)
        let defTip = UserDefaults.standard.double(forKey: "defaultTip")
        defaultTip.text = String(defTip)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Change skin color if button is switched
        let darkSkin = UserDefaults.standard.bool(forKey: "darkSkin")
        changeSkin(darkSkin)
        dsSwitch.setOn(darkSkin, animated: true)
    }
    
    func changeSkin(_ shouldChange: Bool) {
        if shouldChange {
            view.backgroundColor = black
            DTLabel.textColor = white
            dsLabel.textColor = white
            
        } else {
            view.backgroundColor = white
            DTLabel.textColor = black
            dsLabel.textColor = black
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        //Tap outside field to update
        view.endEditing(true)
        //For saving default global
    }
     
    @IBAction func eraseContents(_ sender: Any) {
        defaultTip.text = ""
    }
    
    @IBAction func onChange(_ sender: Any) {
        let dTip = Double(defaultTip.text!) ?? 0
        if dTip < 1 {
            //Incase the user put decimal
            UserDefaults.standard.set(dTip, forKey: "defaultTip")
        } else {
            UserDefaults.standard.set(dTip / 100, forKey: "defaultTip")
        }
    }
    @IBAction func skinChange(_ sender: Any) {
        //Save in defaults
        UserDefaults.standard.set(dsSwitch.isOn, forKey: "darkSkin")
        //changeSkin(dsSwitch.isOn)
    }
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
