//
//  ViewController.swift
//  Todoey
//
//  Created by Oscar Lihou-Smith on 22/09/2019.
//  Copyright © 2019 Oscar Lihou-Smith. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //MARK:- Properties
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Initial Items in Todo list
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "But Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }
    
    //MARK:- Tableview Datasource Methods
    
    //TODO: Declare how many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    //TODO: Populate the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //This does the same as below
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //This does the same as below, this is a ternary operator
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        
        return cell
        
    }
    
    //TODO: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //This does the same as below
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        
        
        tableView.reloadData()
        
        //Makes the cell flash grey when clicked
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK:- Add new items
    @IBAction func addButtonPresses(_ sender: UIBarButtonItem) {
        
        //global variable to hold the user input
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            print("Success")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        //creates a text field for the user to input thier Todoey item
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //adds action to the alert
        alert.addAction(action)
        
        //shows the alert
        present(alert, animated: true, completion: nil)
        
    }
    
}
