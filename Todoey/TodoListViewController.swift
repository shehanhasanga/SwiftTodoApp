//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var items = ["Find mike", "Buy eggs" , "Destroy demo"]
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  let  itemsarr = userDefaults.array(forKey: "TodoList") as? [String] {
            items = itemsarr
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonClick(_ sender: UIBarButtonItem) {
        var uiTextField = UITextField()
        let alert = UIAlertController(title: "Add new todo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            self.items.append(uiTextField.text!)
            self.userDefaults.set(self.items, forKey: "TodoList")
            self.tableView.reloadData()
         
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Created a new item"
            uiTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

