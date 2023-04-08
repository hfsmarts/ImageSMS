//
//  UtilityFunctions.swift
//  ImageSMS
//
//  Created by Harun Fazlic on 8. 4. 2023..
//

import UIKit

struct UtilityFunctions{
    
    func setPlaceHolderColor(placeHolderText: String, placeHolder: UITextField){
        placeHolder.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
}
