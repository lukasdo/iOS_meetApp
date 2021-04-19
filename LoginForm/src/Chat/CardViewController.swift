//
//  OverViewController.swift
//  LoginForm
//
//  Created by Lukas on 06.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
//

import Foundation
import UIKit
import Shuffle_iOS
import Alamofire
import FirebaseAuth

class OverViewController: UIViewController, SwipeCardStackDataSource, SwipeCardStackDelegate, APIDelegate{
  
    
    
    var newTitle: String?
    var window: UIWindow?
    var safeArea: UILayoutGuide!
    var newSafeArea: UIEdgeInsets?
    let cardStack = SwipeCardStack()
    let apiWrapper = APIWrapper()
//    let data = try? Data(contentsOf: URL(fileURLWithPath: "https://firebasestorage.googleapis.com/v0/b/justetfs.appspot.com/o/_mhmi6_W_400x400.jpg?alt=media&token=3d184279-57a6-40c4-9fe6-8839dd5662ae"))

    var cardImages: [UIImage?]?
    private var profileModels: [UserStruct]?
    let child = SpinnerViewController()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newTitle
        view.backgroundColor = .white
        apiWrapper.delegate = self
        
        apiWrapper.getProfiles()
        view.addSubview(cardStack)
        let frame = CGRect(x: 0, y: 5 + (self.navigationController?.toolbar.frame.size.height)! , width: view.safeAreaLayoutGuide.layoutFrame.width, height: (view.safeAreaLayoutGuide.layoutFrame.height - (self.navigationController?.toolbar.frame.size.height)! - (self.navigationController?.toolbar.frame.size.height)! ) )
       newSafeArea = UIEdgeInsets()
        if let sideViewWidth = self.navigationController?.toolbar.frame.size.height {
            newSafeArea?.top += sideViewWidth
        }
        if let bottomViewHeight = self.navigationController?.toolbar.frame.size.height {
            newSafeArea?.bottom += bottomViewHeight
        }
        cardStack.frame = frame
        cardStack.dataSource = self
        cardStack.delegate = self
        
 
    }
    func updateUserProfile(users: [UserStruct]) {
        self.profileModels = users
        self.cardStack.reloadData()
    }
    func card(id: String,index: Int) -> SwipeCard {
        //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        let card = SwipeCard()
        
//        FirebaseDB().returnProfileUrl(id: id) { (url) in
//            if let downUrl = url {
                let view = UIImageView()
//                view.downloadImageAsync(url: downUrl)
                
                card.content = TinderCardContentView(url: "downUrl")
                card.footer = TinderCardFooterView(withTitle: self.profileModels?[index].name, subtitle: "Subtitle")
//            }
//        }
      return card
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        guard let id = self.profileModels?[index].userId else {
            return SwipeCard()
        }
        let cardSt = self.card(id: id,index: index)
        cardSt.swipeDirections = [.left, .up, .right]
     
//
        
        return cardSt
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return profileModels?.count ?? 0
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        print(direction)
        if (direction == .right) {
            
           
          
            if profileModels![index].likes.firstIndex(of: Auth.auth().currentUser?.uid ?? "") != nil {
                
            //Set Like in Backend
                if let uid = Auth.auth().currentUser?.uid {
                    let body = ["currentUser":  uid ,"likedUser": profileModels![index].userId] as [String : Any]
                    let bodyData = (try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted))!
                    apiWrapper.likeProfile(body: bodyData)
                }
            } else {
         
            // Match
                if let uid = Auth.auth().currentUser?.uid {
                    let body = ["currentUser":  uid ,"likedUser": profileModels![index].id] as [String : Any]
                    let bodyData = (try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted))!
                    apiWrapper.likeProfile(body: bodyData)
                }
             
            }
        } else if (direction == .left) {
            
        }
    }
    
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("DidSelect")
    
    }

    
}
