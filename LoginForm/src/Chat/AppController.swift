//
//  AppController.swift
//  LoginForm
//
//  Created by Lukas on 03.03.20.
//  Copyright © 2020 Lukas. All rights reserved.
// https://medium.com/@ITZDERR/uinavigationcontroller-and-uitabbarcontroller-programmatically-swift-3-d85a885a5fd0

import Foundation
import UIKit

class AppController: UIViewController {
    
    var tabBarCntrl: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "Main"
        
        tabBarCntrl = UITabBarController()
        let searchVC = DummyController()
        searchVC.newTitle = "Search"
        searchVC.view.backgroundColor = UIColor.orange
        
        

        let messagesVC = ContactsViewController()
        messagesVC.newTitle = "Contacts"
//        messagesVC.view.backgroundColor = UIColor.orange
        
        
        let chatVC = OverViewController()
        chatVC.newTitle = "Chats"
//        chatVC.view.backgroundColor = UIColor.blue
        
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        chatVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        messagesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        
        let controllers = [searchVC, chatVC,messagesVC]
        tabBarCntrl.viewControllers = controllers
        
        tabBarCntrl.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}

//        addChildViewController(tabBarCntrl)
        view.addSubview(tabBarCntrl.view)
        
//        tabBarCntrl.view.translatesAutoresizingMaskIntoConstraints = false
//        let margins = view.layoutMarginsGuide
//           NSLayoutConstraint.activate([
//            tabBarCntrl.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
//            tabBarCntrl.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
//        ])
        tabBarCntrl.didMove(toParent: self)
  
    }

}
