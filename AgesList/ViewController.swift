//
//  ViewController.swift
//  AgesList
//
//  Created by Руслан Акберов on 14.01.2018.
//  Copyright © 2018 Ruslan Akberov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
        } catch {
            print("Fetch Request error!")
        }
    }

    @IBAction func onPlusTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        let actionPost = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            print(name, age)
            let person = Person(context: PersistenceService.context)
            person.name = name
            person.age = Int16(age)!
            PersistenceService.saveContext()
            self.people.append(person)
            self.tableview.reloadData()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionPost)
        alert.addAction(actionCancel)        
        present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].age)
        return cell
    }
}




















