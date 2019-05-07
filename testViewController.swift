//
//  ViewController.swift
//  Table List
//
//  Created by Gabriel Wilk Mizrahi on 4/26/19.
//  Copyright © 2019 Gabriel Wilk Mizrahi. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            if indexPath.row % 5 == 0 {
                label.text = "take a job"
            }
            else if indexPath.row % 5 == 1 {
                label.text = "watch a movie"
            }
            else if indexPath.row % 5 == 2 {
                label.text = "Code an app"
            }
            else if indexPath.row % 5 == 3 {
                label.text = "Walk the dog"
            }
            else if indexPath.row % 5 == 4 {
                label.text = "study design patterns"
            }
            else {
                label.text = "Sleep"
            }
        }
        return cell
    }
    
}

extension TestViewController: UITableViewDelegate {
    
}

