//
//  Extension.swift
//  Employee
//
//  Created by Karthik on 9/24/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit


extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    var isNotEmpty : Bool {
        return !isEmpty
    }

}

extension UIViewController {
    func showAlert() {
          let alert = UIAlertController(title: "Error", message: "Please enter all details", preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          self.present(alert, animated: true, completion: nil)

      }
    
    func showAlert(with msg : String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)

    }

}
