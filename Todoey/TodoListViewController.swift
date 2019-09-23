//
//  ViewController.swift
//  Todoey
//
//  Created by Oscar Lihou-Smith on 22/09/2019.
//  Copyright © 2019 Oscar Lihou-Smith. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //Properties
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    //TODO: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //Adds a checkmark to the cell if it doesn't already have one when clicked
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(textField.text!)
            
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
