//
//  ViewController.swift
//  ImageSMS
//
//  Created by Harun Fazlic on 8. 4. 2023..
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var senderName: UITextField!
    @IBOutlet var message: UITextField!
    @IBOutlet var imageInMessage: UIImageView!
    
    //placeholders
    @IBOutlet var numberPlaceHolder: UITextField!
    @IBOutlet var namePlaceholder: UITextField!
    @IBOutlet var messagePlaceholder: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        //imageInMessage.backgroundColor = .red
        //imageInMessage.image = UIImage(named: "defaultImage")
        //imageInMessage.contentMode = .scaleAspectFit

        UtilityFunctions().setPlaceHolderColor(placeHolderText: "+38761222111", placeHolder: numberPlaceHolder)
        UtilityFunctions().setPlaceHolderColor(placeHolderText: "Mujo Mujic", placeHolder: namePlaceholder)
        UtilityFunctions().setPlaceHolderColor(placeHolderText: "Wish you all the best!", placeHolder: messagePlaceholder)
        
    }
    
    @IBAction func browseForTheImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageInMessage.image = image
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

