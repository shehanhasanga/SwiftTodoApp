//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var items = [Item]()
    var userDefaults = UserDefaults.standard
//    var  filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = Item(title: "Find Mike")
        let item2 = Item(title: "Buy Eggs")
        let item3 = Item(title: "Do home works")
        items.append(item1)
        items.append(item2)
        items.append(item3)
        
        
//        if  let  itemsarr = userDefaults.array(forKey: "TodoList") as? [Item] {
//            items = itemsarr
//        }
        if let data = UserDefaults.standard.data(forKey: "TodoList") {
            do {
                let decoder = JSONDecoder()
                let itemsarr = try decoder.decode([Item].self, from: data)
                items = itemsarr

            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func addButtonClick(_ sender: UIBarButtonItem) {
        var uiTextField = UITextField()
        let alert = UIAlertController(title: "Add new todo", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { action in
            let item = Item(title: uiTextField.text!)
            self.items.append(item)
            self.saveData()
           
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
        cell.textLabel?.text = items[indexPath.row].title
        
        cell.accessoryType = items[indexPath.row].done ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items[indexPath.row].done {
            items[indexPath.row].done = false
        } else {
            items[indexPath.row].done = true
        }
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func saveData(){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(items)
            UserDefaults.standard.set(data, forKey: "TodoList")

        } catch {
            print("Unable to Encode Note (\(error))")
        }
        tableView.reloadData()
    }

}

