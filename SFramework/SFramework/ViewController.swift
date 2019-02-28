//
//  ViewController.swift
//  SFramework
//
//  Created by 123 on 2019/2/1.
//  Copyright © 2019 hxs. All rights reserved.
//

import UIKit
import XSBase

class ViewController: XSViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = XSTableViewCell.cell(with: tableView)
        cell.textLabel?.text = "title"
        return cell
    }
    
}

