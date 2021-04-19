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
        
          self.loadChats() {matches,error  in
                if let err = error {
                    print(err)
                }
                self.matches = matches
                self.tableView.reloadData()
            }
 
        
    }
    override func viewDidLoad() {
       super.viewDidLoad()
        self.title = newTitle
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.loadChats()
//            // Bounce back to the main thread to update the UI
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        
   
     }
    
    func loadChats(completion: @escaping ([Matches], Error?) -> Void) {
        let db = Firestore.firestore().collection("Matches").whereField(FieldPath.documentID(), isEqualTo: currentUser?.uid)
                
        var matchArray = [Matches]()
        db.getDocuments { (chatQuerySnap, error) in
            
            if let error = error {
                print("Error: \(error)")
                completion(matchArray,error)
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
                            matchArray.append(match!)
                            print(self.matches)
                    
                        }
                        completion(matchArray, nil)
                      
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
