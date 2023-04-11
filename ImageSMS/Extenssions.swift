//
//  Extenssions.swift
//  ImageSMS
//
//  Created by Harun Fazlic on 8. 4. 2023..
//

import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}



//        let accountSid = "ACd6060459ce0937f6d3a0018b0046f79b"
//        let authToken = "23374c1059709a20f990a56cbb7262f2"
//        let urlString = "https://api.twilio.com/2010-04-01/Accounts/\(accountSid)/Messages.json"
//        let url = URL(string: urlString)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let body = "Message from: \(namePlaceholder.text!). Message text: \(messagePlaceholder.text!) "
//        let from = "+15673991807"
//        let to = "+\(numberPlaceHolder.text!)"
//        let params = "Body=\(body)&From=\(from)&To=\(to)" /*&MediaUrl=\(imagePath)*/
//        request.httpBody = params.data(using: .utf8)
//        let loginString = "\(accountSid):\(authToken)"
//        let loginData = loginString.data(using: .utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//
//                UtilityFunctions().errorAlert(vc: self)
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//
//                UtilityFunctions().errorAlert(vc: self)
//                print("Error: Invalid response")
//                return
//            }
//
//            guard let data = data else {
//
//                UtilityFunctions().errorAlert(vc: self)
//                print("Error: No data received")
//                return
//            }
//
//            UtilityFunctions().success(vc: self)
//            print(String(data: data, encoding: .utf8)!)
//        }
//        task.resume()
