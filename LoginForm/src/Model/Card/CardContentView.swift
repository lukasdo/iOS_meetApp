//
//  CardContentView.swift
//  LoginForm
//
//  Created by Lukas on 26.03.21.
//  Copyright © 2021 Lukas. All rights reserved.
//

import Foundation
import UIKit

class TinderCardContentView: UIView {

  private let backgroundView: UIView = {
    let background = UIView()
    background.clipsToBounds = true
    background.layer.cornerRadius = 10
    return background
  }()

    private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  private let gradientLayer: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.black.withAlphaComponent(0.01).cgColor,
                       UIColor.black.withAlphaComponent(0.8).cgColor]
    gradient.startPoint = CGPoint(x: 0.5, y: 0)
    gradient.endPoint = CGPoint(x: 0.5, y: 1)
    return gradient
  }()

    init(url: String) {
    super.init(frame: .zero)
    imageView.downloadImageAsync(url: "https://firebasestorage.googleapis.com/v0/b/justetfs.appspot.com/o/7scVIgCpfYZxx3GbMVupbr1VABx1%2FuserPhoto?alt=media&token=2f0c7f77-d2e9-416a-92c2-9def7e7d4366")
    self.initialize()


 
  }

  required init?(coder aDecoder: NSCoder) {
    return nil
  }

  private func initialize() {
    addSubview(backgroundView)
    backgroundView.anchorToSuperview()
    backgroundView.addSubview(imageView)
    imageView.anchorToSuperview()
    applyShadow(radius: 8, opacity: 0.2, offset: CGSize(width: 0, height: 2))
    backgroundView.layer.insertSublayer(gradientLayer, above: imageView.layer)
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let heightFactor: CGFloat = 0.35
    gradientLayer.frame = CGRect(x: 0,
                                 y: (1 - heightFactor) * bounds.height,
                                 width: bounds.width,
                                 height: heightFactor * bounds.height)
  }
}
