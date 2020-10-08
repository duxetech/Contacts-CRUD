//
//  EmployeeCell.swift
//  Employee
//
//  Created by Karthik on 9/24/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet var firstName: UILabel!
    
    @IBOutlet var lastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func configureCell(emp : Employee) {
        firstName.text = emp.firstName
        lastName.text = emp.lastName
    }

  
    
    
}
