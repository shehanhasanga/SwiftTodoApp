//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by shehan karunarathna on 2022-01-23.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    var items = [ItemCategory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        var uiTextField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
           
            let newItem = ItemCategory(context: self.context)
            newItem.name =  uiTextField.text!
            
//            let item = Item(title: uiTextField.text!)
            self.items.append(newItem)
            self.saveData()
           
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create a new Category"
            uiTextField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = items[indexPath.row]
        }
    }
    
    func saveData(){
        do {
            try context.save()

        } catch {
            print("Unable to save data (\(error))")
        }
        tableView.reloadData()
    }
    
    func fetchData(){
            let request : NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest()
            request.returnsObjectsAsFaults = false
            do {
                items = try context.fetch(request)
              
            } catch {
                print("Fetching data Failed")
            }
        }


}
