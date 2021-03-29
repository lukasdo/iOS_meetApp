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
    
    
    var matches = [Matches?]()
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.loadChats()
            self.tableView.reloadData()
        }
   
        
    }
    override func viewDidLoad() {
       super.viewDidLoad()
        self.title = newTitle
        
        
//        DispatchQueue.main.async {
//            self.loadChats()
//            self.tableView.reloadData()
//        }
   
     }
    
    func loadChats() {
        let db = Firestore.firestore().collection("Matches").whereField(FieldPath.documentID(), isEqualTo: currentUser?.uid)
                
        
        db.getDocuments { (chatQuerySnap, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                
                //Count the no. of documents returned
                guard let queryCount = chatQuerySnap?.documents.count else {
                    return
                }
                
                if queryCount == 0 {
                    //in case of no matches create doc
//                    self.createNewChat()
                }
                for doc in chatQuerySnap!.documents {
                
                    doc.reference.collection("matches").getDocuments{ (query,err) in
                        
                        for docum in query!.documents {
                            var match = Matches(dictionary: docum.data())
                            print(match)
                            self.matches.append(match!)
                            print(self.matches)
                        
                        }
                      
                    }
              
                    
           
                }

                
            }
            
        }
    }

     // MARK: tableView
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count // set to value needed
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()

        cell.textLabel?.text = matches[indexPath.row]?.mail
        return cell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController()
        chatVC.user2Name = matches[indexPath.row]?.mail
        chatVC.user2UID = matches[indexPath.row]?.id
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
}


extension Collection where Element: Equatable {

    func intersection(with filter: [Element]) -> [Element] {
        return self.filter { element in filter.contains(element) }
    }

}
