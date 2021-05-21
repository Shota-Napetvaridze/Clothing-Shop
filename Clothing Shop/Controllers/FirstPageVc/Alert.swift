//
//  Alert.swift
//  Clothing Shop
//
//  Created by MacBook Pro on 21.05.21.
//

import UIKit

class myalert {
    static func showAlert(title: String, message: String, vc: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
