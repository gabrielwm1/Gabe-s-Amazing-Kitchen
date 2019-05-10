//
//  toDoList.swift
//  Table List
//
//  Created by Gabriel Wilk Mizrahi on 4/27/19.
//  Copyright © 2019 Gabriel Wilk Mizrahi. All rights reserved.
//

import Foundation

class TodoList {
    
    var todos: [checklistItem] = []
    
    init() {
        
        let row0Item = checklistItem()
        let row1Item = checklistItem()
        let row2Item = checklistItem()
        let row3Item = checklistItem()
        let row4Item = checklistItem()
        
        row0Item.text = "Take a jog"
        row1Item.text = "Watch a movie"
        row2Item.text = "Code an app"
        row3Item.text = "Walk the dog"
        row4Item.text = "Study design patterns"
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
        
    }
    
    func newTodo () -> checklistItem {
        let item = checklistItem()
        item.text = randomTitle()
        item.checked = true
        todos.append(item)
        return item
    }
    
    func move(item: checklistItem, to index: Int){
        guard let currentIndex = todos.index(of: item) else {
            return
        }
        todos.remove(at: currentIndex)
        todos.insert(item, at: index)
    }
    
    private func randomTitle() -> String {
    
        var titles = ["new", "what", "whatsup", "what going on"]
        let randomNumber = Int.random(in: 0 ... titles.count - 1)
        return titles[randomNumber]
    }
}
