//
//  AddItemTableViewController.swift
//  Table List
//
//  Created by Gabriel Wilk Mizrahi on 4/29/19.
//  Copyright © 2019 Gabriel Wilk Mizrahi. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    
    func itemDetailViewControllerDidCancel(_ controller: itemDetailViewController)
    func itemDetailViewController(_ controller: itemDetailViewController, didFinishAdding item: checklistItem)
    func itemDetailViewController(_ controller: itemDetailViewController, disFinishEditing item: checklistItem)
}

class itemDetailViewController: UITableViewController {

    weak var delegate: ItemDetailViewControllerDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: checklistItem?
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var colorTextField: UITextField!
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit, let text = textField.text, let colorText = colorTextField.text {
            item.text = text
            item.color = colorText
            delegate?.itemDetailViewController(self, disFinishEditing: item)
        } else {
            if let item = todoList?.newTodo() {
            if let textFieldText = textField.text {
                item.text = textFieldText
            }
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
    extension itemDetailViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            guard let oldText = textField.text,
                let stringRange = Range(range, in: oldText) else {
                    return false
            }
            
            let newText = oldText.replacingCharacters(in: stringRange, with: string)
            if newText.isEmpty {
                addBarButton.isEnabled = false
            } else {
                addBarButton.isEnabled = true
            }
            return true
        }
    }
