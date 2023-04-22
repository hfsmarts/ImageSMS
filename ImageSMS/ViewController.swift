//
//  ViewController.swift
//  ImageSMS
//
//  Created by Harun Fazlic on 8. 4. 2023..
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var senderName: UITextField!
    @IBOutlet var message: UITextField!
    @IBOutlet var imageInMessage: UIImageView!
    @IBOutlet var numberPlaceHolder: UITextField!
    @IBOutlet var namePlaceholder: UITextField!
    @IBOutlet var messagePlaceholder: UITextField!
    @IBOutlet var sendButton: UIButton!
    var uploadedImageURL: String? = nil
    var isImageUploaded = false
    var isTextPresent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        UtilityFunctions().setPlaceHolderColor(placeHolderText: "38761222111", placeHolder: numberPlaceHolder)
        UtilityFunctions().setPlaceHolderColor(placeHolderText: "John Wick", placeHolder: namePlaceholder)
        UtilityFunctions().setPlaceHolderColor(placeHolderText: "Wish you all the best!", placeHolder: messagePlaceholder)
        sendButton.isEnabled = false
        namePlaceholder.limitNumOfChar(20)
        messagePlaceholder.limitNumOfChar(160)
    }
    
    func uploadImageToImgur(image: UIImage, completion: @escaping (Result<String, Error>) -> Void)  {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "com.yourapp.upload", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG data"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": UtilityFunctions().keyGenerator(key: "ClientID")
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
        }, to: "https://api.imgur.com/3/image", headers: headers)
        .validate()
        .responseDecodable(of: ImgurUploadResponse.self) { response in
            switch response.result {
            case .success(let uploadResponse):
                completion(.success(uploadResponse.data.link))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if let phoneNumber = phoneNumber.text,
           let namePlaceholder = namePlaceholder.text,
           let messagePlaceholder = messagePlaceholder.text,
           !phoneNumber.isEmpty,
           !namePlaceholder.isEmpty,
           !messagePlaceholder.isEmpty{
            isTextPresent = true
        } else {
            isTextPresent = false
        }
        if isTextPresent && isImageUploaded {
            sendButton.isEnabled = true
        }
    }
    
    @IBAction func browseForTheImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = false
        present(vc, animated: true)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        let accountSid = UtilityFunctions().keyGenerator(key: "accountSid")
        let authToken = UtilityFunctions().keyGenerator(key: "authToken")
        let urlString = "https://api.twilio.com/2010-04-01/Accounts/\(accountSid)/Messages.json"
        let body = "Message from: \(namePlaceholder.text!). Message text: \(messagePlaceholder.text!) "
        let from = "+15673991807"
        let to = "+\(numberPlaceHolder.text!)"
        let parameters: [String: Any] = [
            "Body": body,
            "From": from,
            "To": to,
            "MediaUrl": uploadedImageURL!
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders(["Authorization": "Basic \(Data("\(accountSid):\(authToken)".utf8).base64EncodedString())"])).response { response in
            if response.error != nil {
                UtilityFunctions().errorAlert(vc: self)
                return
            }
            
            guard let statusCode = response.response?.statusCode,
                  (200...299).contains(statusCode) else {
                UtilityFunctions().errorAlert(vc: self)
                return
            }
            
            guard response.data != nil else {
                UtilityFunctions().errorAlert(vc: self)
                return
            }
            UtilityFunctions().success(vc: self)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.sendButton.isEnabled = false
            uploadImageToImgur(image: image) { [self] result in
                switch result {
                case .success(let imageURL):
                    self.uploadedImageURL = imageURL
                    self.isImageUploaded = true
                    if isTextPresent && isImageUploaded {
                        self.sendButton.isEnabled = true
                    }
                case .failure(_):
                    UtilityFunctions().errorAlert(vc: self)
                    self.sendButton.isEnabled = false
                }
            }
            imageInMessage.image = image
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    
}







