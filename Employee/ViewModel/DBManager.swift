//
//  DB.swift
//  Employee
//
//  Created by Karthik on 9/24/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit
import CoreData

class DBManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var employees = [Employee]()
    let request : NSFetchRequest = EmployeeEntity.fetchRequest()

    func saveData(emp : Employee) {
        let entity = EmployeeEntity(context:context)
        entity.firstName = emp.firstName
        entity.lastName = emp.lastName
        entity.designation = emp.designation
        entity.email = emp.email
        entity.phone = emp.phone
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveData(comp : @escaping ([Employee])->()) {
        employees.removeAll()

        do {
          let entity = try context.fetch(request)
            for i in entity {
                let first = i.value(forKey: "firstName")
                let last = i.value(forKey: "lastName")
                let mail = i.value(forKey: "email")
                let phone = i.value(forKey: "phone")
                let desig = i.value(forKey: "designation")
                employees.append(Employee(firstName: first as! String, lastName: last as! String, email: mail as! String, phone: phone as! String, designation: desig as! String))
            }
            comp(employees)
            print(employees.map{$0.firstName})

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateData(index: Int, emp : Employee) {

        do {
            let ent = try context.fetch(request)
            ent[index].setValue(emp.firstName, forKey: "firstName")
            ent[index].setValue(emp.lastName, forKey: "lastName")
            ent[index].setValue(emp.email, forKey: "email")
            ent[index].setValue(emp.phone, forKey: "phone")
            ent[index].setValue(emp.designation, forKey: "designation")
            try context.save()

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(index : Int){
        do {
        let entity = try context.fetch(request)
        context.delete(entity[index])
        try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
