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
    
    func generateQRCode(ssid : String, password : String) -> UIImage
    {
        let textData = (ssid + ":" + password).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter.setValue(textData, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel") // error-correction level: H=30%, Q=25%, M=15% (default), L=7%
        
        let cgImage = CIContext(options:nil).createCGImage(filter.outputImage, fromRect: filter.outputImage.extent())
        // Now we'll rescale using CoreGraphics
        UIGraphicsBeginImageContext(CGSizeMake(350, 350));
        let context = UIGraphicsGetCurrentContext()
        // We don't want to interpolate (since we've got a pixel-correct image)
        CGContextSetInterpolationQuality(context, kCGInterpolationNone);
        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
        // Get the image out
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // Tidy up
        UIGraphicsEndImageContext();
        
        return scaledImage!

    }
}