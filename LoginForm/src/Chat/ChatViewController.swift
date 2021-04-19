//
//  ChatViewController.swift
//  LoginForm
//
//

//TODO:: FIREBASE STRUCT
//|- Chats (Collection)
//| — AutoID (Document)
//| —- users (Field {Array})
//| —- thread(Collection)
//| — — AutoID (Document)
//| — —- content (Field {String})
//| — —- created (Field {DateTime})
//| — —- id (Field {String})
//| — —- senderID (Field {String})
//| — —- senderName (Field {String})
//  Created by Lukas on 03.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
// https://www.raywenderlich.com/5359-firebase-tutorial-real-time-chat

import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseAuth
import FirebaseFirestore
import UIKit

class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var newTitle: String?
    let currentUser = Auth.auth().currentUser
    private var docReference: DocumentReference?
    var messages: [Message] = []
    
    var user2Name: String!
    var user2ImgUrl: String!
    var user2UID: String!
    let urlString = "https://firebasestorage.googleapis.com/v0/b/justetfs.appspot.com/o/_mhmi6_W_400x400.jpg?alt=media&token=3d184279-57a6-40c4-9fe6-8839dd5662ae"
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        user2Name = currentUser?.displayName ?? currentUser?.email
//        user2UID =
//        user2ImgUrl = currentUser?.photoURL
        
        self.title = user2Name ?? "Chat"
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//                   navBar.setItems([navigationItem], animated: true)
        
                  
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(backAction(_:)))

        let callButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(backAction(_:)))
      
        navigationItem.backBarButtonItem = backButton
        navigationItem.hidesBackButton = false
        navigationItem.largeTitleDisplayMode = .never
            
        navigationItem.rightBarButtonItem = callButton
        self.navigationItem.setLeftBarButtonItems([backButton], animated: true)


        self.navigationItem.backBarButtonItem = backButton
        self.navigationItem.hidesBackButton = false
        maintainPositionOnKeyboardFrameChanged = true
        
        
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        loadChat()
    }
    
    func currentSender() -> SenderType {
        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return self.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
       if messages.count == 0 {
        print("There are no messages")
        return 0
        } else {
        return messages.count
        }

    }
    
    func loadChat() {
        
        //Fetch all the chats which has current user in it
     let db = Firestore.firestore().collection("Chats")
             .whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
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
                 //If documents count is zero that means there is no chat available and we need to create a new instance
                 self.createNewChat()
             }
             else if queryCount >= 1 {
                 //Chat(s) found for currentUser
                 for doc in chatQuerySnap!.documents {
                     
                     let chat = Chat(dictionary: doc.data())
                     //Get the chat which has user2 id
                    if (chat?.users.contains(self.user2UID!))! {
                         
                         self.docReference = doc.reference
                         //fetch it's thread collection
                          doc.reference.collection("thread")
                             .order(by: "created", descending: false)
                             .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                         if let error = error {
                             print("Error: \(error)")
                             return
                         } else {
                             self.messages.removeAll()
                                 for message in threadQuery!.documents {

                                     let msg = Message(dictionary: message.data())
                                     self.messages.append(msg!)
                                     print("Data: \(msg?.content ?? "No message found")")
                                 }
                             self.messagesCollectionView.reloadData()
                             self.messagesCollectionView.scrollToBottom(animated: true)
                         }
                         })
                         return
                     } //end of if
                 } //end of for
                 self.createNewChat()
             } else {
                 print("Let's hope this error never prints!")
             }
         }
     }
    }
    
    func createNewChat() {
        let users = [ self.currentUser!.email!, self.currentUser!.uid,  self.user2Name, self.user2UID]
//        let users = [self.currentUser?.uid, self.user2UID, self.currentUser?.email, self.user2Name]
        let data: [String: Any] = [ "users":users ]
        
        let db = Firestore.firestore().collection("Chats")
        db.addDocument(data: data) { (error) in
            if let error = error {
                print("Unable to create chat! \(error)")
                return
            } else {
                self.loadChat()
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    private func save(_ message: Message) {
        
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        
        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
            
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            
            self.messagesCollectionView.scrollToBottom()
            
        })
    }
    
    
    // MARK: - InputBarAccessoryViewDelegate
      
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("pressed")

        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser!.uid , senderName: currentUser!.email!)
          
            //messages.append(message)
            insertNewMessage(message)
            save(message)

            inputBar.inputTextView.text = ""
            messagesCollectionView.reloadData()
            messagesCollectionView.scrollToBottom(animated: true)
      }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {

          let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
          return .bubbleTail(corner, .curved)

      }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
     


//        if let url = URL(string: urlString) {
        DispatchQueue.global(qos: .background).async {
            print("This is run on a background queue")
            FirebaseDB().returnProfileUrl(id: message.sender.senderId,completion: { url in
                if let downUrl = url {
                    avatarView.downloadImageAsync(url: downUrl)
                }
            })
            
        }
        
        
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
         return isFromCurrentSender(message: message) ? .blue: .lightGray
     }

      @objc func backAction(_ sender: UIButton) {
            print("Dismiss")
        self.navigationController?.popViewController(animated: true)
        }

}

extension UIImageView {
    func downloadImageAsync(urlString: String, defaultImage: UIImage, success: @escaping ()->(), failure: @escaping ()->()) {
//        var imageCach: ImageCache
        if let image = ImageCache.shared.get(key: urlString) {
            self.image = image
        } else {
            // We can set default image here
            self.image = defaultImage
            DispatchQueue.global().async (execute: {
                guard let url = URL(string: urlString) else {
                    DispatchQueue.main.sync(execute: {
                        failure()
                    })
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.sync(execute: {
                        failure()
                    })
                    return
                }
                guard let image = UIImage(data: data) else {
                    return
                }
                ImageCache.shared.set(key: urlString, image: image)
                DispatchQueue.main.sync (execute: {
                    self.image = image
                    success()
                })
            })
        }
    }
    
    func downloadImageAsync(url: String) {
         self.downloadImageAsync(urlString: url, defaultImage: UIImage(), success: {
             
         }, failure: {
             
         })
     }
}


public struct Chats: Codable {

    let user_mail: String
    let user_id: String
    let user_mail1: String
    let user_id1: String
    
}


