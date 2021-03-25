//
//  OverViewController.swift
//  LoginForm
//
//  Created by Lukas on 06.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import Foundation
import UIKit

class OverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var newTitle: String?
    var window: UIWindow?
    let tableView = UITableView()

    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newTitle

        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        print(safeArea.layoutFrame)
        setupTableView()
        

        tableView.delegate = self
        tableView.dataSource = self
        
    
    }
    
    func setupTableView() {
      view.addSubview(tableView)
      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigate 
    }
    
  
}

