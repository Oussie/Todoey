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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        print(dataFilePath!)
        
        loadItems()
        
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

        self.saveItems()
        
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
    
            self.saveItems()
        
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
    
    
    //MARK:- Function for Saving Data
    
    //TODO: add saveItems function
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()

    }
    
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        
        }

    }

}
