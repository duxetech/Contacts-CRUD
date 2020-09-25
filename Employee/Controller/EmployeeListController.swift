//
//  ViewController.swift
//  Employee
//
//  Created by Karthik on 9/24/20.
//  Copyright © 2020 Karthik. All rights reserved.
//

import UIKit

class EmployeeListController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let db = DBManager()
    var employees : [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let back = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: nil)
        navigationItem.backBarButtonItem = back

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        db.retrieveData {
            emp in
            self.employees = emp
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        launch(mode: "add", index: 0)
    }
    
}

extension EmployeeListController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! EmployeeCell
        cell.configureViewsI(emp: employees[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        launch(mode: "view", index: indexPath.row)
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            db.deleteData(index: indexPath.row)
            db.retrieveData { emp in
                self.employees = emp
                tableView.reloadData()
            }
        }
    }
    
    func launch(mode : String, index : Int) {
        let s = UIStoryboard(name: "Main", bundle: nil)
            
        let controller = s.instantiateViewController(identifier: "EmployeeDetailsController") as! EmployeeDetailsController
        controller.index = index
        controller.mode = mode
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

