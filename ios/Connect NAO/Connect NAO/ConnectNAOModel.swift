//
//  ConnectNAOModel.swift
//  Connect NAO
//
//  Created by Alan Rushforth on 13/04/2015.
//  Copyright (c) 2015 Alan Rushforth. All rights reserved.
//

import Foundation
import CoreImage
import CoreGraphics
import UIKit
import SystemConfiguration.CaptiveNetwork

class ConnectNAOModel
{
    var currentSSID: String? {
        get
        {
            if let interfaces = CNCopySupportedInterfaces()
            {
                let interfacesArray = interfaces.takeRetainedValue() as! [String]

                if !interfacesArray.isEmpty
                {
                    let interfaceName = interfacesArray[0]
                    
                    if let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName) {
                        let interfaceData = unsafeInterfaceData.takeRetainedValue() as Dictionary
                        let ssid = interfaceData["SSID"] as! String?
                        return (ssid != nil) ? ssid : ""
                    }
                }
            }
            return ""
        }
    }
    
    func generateQRCode(ssid : String, password : String) -> CIImage
    {
        let data = (ssid + ":" + password).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        
        let qrCodeImage = filter.outputImage
        return qrCodeImage
    }
}