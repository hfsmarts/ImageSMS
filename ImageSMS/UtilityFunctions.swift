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
    
    func errorAlert(vc: UIViewController){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func success(vc: UIViewController){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Success", message: "Message sent!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            }
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
   
    
}
