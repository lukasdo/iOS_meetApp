//
//  SpinnerViewController.swift
//  LoginForm
//
//  Created by Lukas on 15.04.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 255, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        spinner.hidesWhenStopped = true
    }
    
    func start() {
        spinner.startAnimating()
    }
    
    func stop() {
        spinner.stopAnimating()
    }
}
