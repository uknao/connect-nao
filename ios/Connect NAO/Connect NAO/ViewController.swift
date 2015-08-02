//
//  ViewController.swift
//  Connect NAO
//
//  Created by Alan Rushforth on 13/04/2015.
//  Copyright (c) 2015 Alan Rushforth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var ssidTextField : UITextField!
    @IBOutlet var pwdTextField : UITextField!
    @IBOutlet var qrImageView : UIImageView!
    
    let model = ConnectNAOModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func generateTapped(sender : AnyObject) {
        let ssid = ((ssidTextField.text != nil) && (!ssidTextField.text.isEmpty)) ? ssidTextField.text : ssidTextField.placeholder
        qrImageView.image = model.generateQRCode(ssid, password: pwdTextField.text)
        self.view.endEditing(true)
    }

    @IBAction func viewTapped(sender : AnyObject) {
        ssidTextField.resignFirstResponder()
        pwdTextField.resignFirstResponder()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            resetUI()
        }
    }
    
    private func resetUI() {
        ssidTextField.placeholder = model.currentSSID
        pwdTextField.text = ""
        qrImageView.image = UIImage(named: "NAOBUTTON")
    }
    
}

