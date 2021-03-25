//
//  ContactsViewController.swift
//  LoginForm
//
//  Created by Lukas on 25.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class ContactsViewController: UITableViewController {

    
    var newTitle: String?
    let currentUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.title = newTitle
        

     }

     // MARK: tableView
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3 // set to value needed
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
       cell.textLabel?.text = "Cell at row \(indexPath.row)"
       return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController()
//        chatVC.user2Name = 
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
}
