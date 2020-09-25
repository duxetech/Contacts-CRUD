//
//  EmployeeDetailsController.swift
//  Employee
//
//  Created by Karthik on 9/24/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit

class EmployeeDetailsController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var designationField: UITextField!
    
    var index = 0
    var item : UIBarButtonItem!
    var mode = ""
    
    let db =  DBManager()
    var input : Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item = navigationItem.rightBarButtonItem
        navigationItem.rightBarButtonItem = item
        phoneField.delegate = self
        let back = navigationItem.leftBarButtonItem
        back?.title="cancel"
        navigationItem.backBarButtonItem = back

        if mode=="add" {
            enableTextFields(true)
            firstNameField.becomeFirstResponder()
            item.title = "Save"
            return
        }
        enableTextFields(false)
        
        db.retrieveData { emp in
            if  emp.count > 0 {
                self.setTextFields(emp: emp[self.index])
            }
        }
        
        
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneField {
            let char = CharacterSet(charactersIn: "+0123456789")
            let set = CharacterSet(charactersIn: string)
            return char.isSuperset(of: set)
        }
        return true
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        
        enableTextFields(true)
        firstNameField.becomeFirstResponder()
        getInputs()
        
        guard let input = input else {
            showAlert()
            return
        }

        if mode == "add" {
            db.saveData(emp: input)
            navigationController?.popToRootViewController(animated: true)
            dismiss(animated: true, completion: nil)
            return
        }
        if mode == "view" {
            db.updateData(index: index, emp: input)
        }
        
        if item.title == "Save" {
            getInputs()
            navigationController?.popToRootViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        item?.title = "Save"
        
    }
    
    func getInputs() {
        guard let first = firstNameField.text, first.isNotEmpty else {
            showAlert()
            return
        }
        guard let last = lastNameField.text, last.isNotEmpty else {
            showAlert()
            return
        }
        guard let phone = phoneField.text, phone.isNotEmpty else {
            showAlert()
            return
        }
        guard let mail = emailField.text, mail.isValidEmail() else {
            showAlert(with: "Please enter valid mail")
            return
        }
        guard let desig = designationField.text, desig.isNotEmpty else {
            showAlert()
            return
        }
        input = Employee(firstName: first, lastName: last, email: mail, phone: phone, designation: desig)
        

    }
    
   
    func enableTextFields(_ yes:Bool) {
        firstNameField.isEnabled = yes
        lastNameField.isEnabled = yes
        phoneField.isEnabled = yes
        emailField.isEnabled = yes
        designationField.isEnabled = yes
    }
    
    func setTextFields(emp : Employee){
        self.firstNameField.text = emp.firstName
        self.lastNameField.text = emp.lastName
        self.phoneField.text = emp.phone
        self.emailField.text = emp.email
        self.designationField.text = emp.designation
    }
    

//
}
