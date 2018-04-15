//
//  ViewController.swift
//  Todoey
//
//  Created by Chris Sipanya on 4/13/18.
//  Copyright © 2018 Chris Sipanya. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destory Demogorgon"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodolistArray") as? [Item]{
            itemArray = items
        }
    }
    
    // MARK -   Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Lets you resue cell over and over again
        print("in dequeue")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //set each cell text with the vaule in array
        

        cell.textLabel?.text = itemArray[indexPath.row].title
       
        
        //Ternary ==>
        //value = condition ? valueTrue : valueIfFalse
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        /*Same as above
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        */
        return cell
    }

    //MARK - Tableview Delegate Methods
    
    //when you pick row this should happen
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       /*same as above set the bool to its opposite
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }
        else{
            itemArray[indexPath.row].done = false
        }
        */
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        print("deselect")
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPress(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item to List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the use clicks the add Item buttonon out UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodolistArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

