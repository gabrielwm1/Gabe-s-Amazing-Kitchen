//
//  ViewController.swift
//  Table List
//
//  Created by Gabriel Wilk Mizrahi on 4/26/19.
//  Copyright © 2019 Gabriel Wilk Mizrahi. All rights reserved.
//

import UIKit

class checkListViewController: UITableViewController {

    var todoList: TodoList
    @IBAction func addItem(_ sender: Any) {
        
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo()
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        print("added item")
    }
    required init?(coder aDecoder: NSCoder) {
       
        todoList = TodoList()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count
    }
    
    func configureText(for cell: UITableViewCell, with item: checklistItem) {
        if let checkmarkCell = cell as? ChecklistTableViewCell {
            checkmarkCell.todoTextLabel.text = item.text
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        let item = todoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with:item
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = todoList.todos[indexPath.row]
            configureCheckmark(for: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        todoList.todos.remove(at: indexPath.row)
        //let indexPaths = [indexPath]
        //tableView.deleteRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: checklistItem){
        guard let checkmarkCell =  cell as? ChecklistTableViewCell else {
            return
        }
            if item.checked {
                checkmarkCell.checkmarkLabel.text = "√"
            } else {
                checkmarkCell.checkmarkLabel.text = ""
            }
        item.toggleChecked()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? itemDetailViewController {
                itemDetailViewController.delegate = self
                itemDetailViewController.todoList = todoList
            }
        }  else if segue.identifier == "EditItemSegue" {
           if let itemDetailViewController = segue.destination as? itemDetailViewController {
                if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                
                let item = todoList.todos[indexPath.row]
                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
        
}

extension checkListViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: itemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: itemDetailViewController, didFinishAdding item: checklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
  }
    
    func itemDetailViewController(_ controller: itemDetailViewController, disFinishEditing item: checklistItem) {
        if let index = todoList.todos.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
           navigationController?.popViewController(animated: true)
        }
}
