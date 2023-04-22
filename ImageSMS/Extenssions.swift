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

extension UITextField {
    func limitNumOfChar(_ limit: Int) {
        addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        objc_setAssociatedObject(self, &AssociatedKeys.limit, limit, .OBJC_ASSOCIATION_RETAIN)
    }

    @objc private func checkMaxLength() {
        guard let limit = objc_getAssociatedObject(self, &AssociatedKeys.limit) as? Int else {
            return
        }
        guard let text = text else {
            return
        }
        if text.count > limit {
            deleteBackward()
        }
    }
}

private struct AssociatedKeys {
    static var limit = "limit"
}
