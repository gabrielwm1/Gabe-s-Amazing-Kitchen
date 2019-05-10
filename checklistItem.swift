//
//  checklistItem.swift
//  Table List
//
//  Created by Gabriel Wilk Mizrahi on 4/26/19.
//  Copyright © 2019 Gabriel Wilk Mizrahi. All rights reserved.
//

import Foundation

class checklistItem: NSObject {
    
    var text = ""
    var checked = false
    var color = ""
    
    func toggleChecked() {
        checked = !checked
    }
}
