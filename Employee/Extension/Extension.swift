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
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let mail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return mail.evaluate(with: self)
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
