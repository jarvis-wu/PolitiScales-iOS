//
//  DuolingoButton.swift
//  DuoUI
//
//  Created by Jarvis Wu on 2/14/20.
//  Copyright © 2020 Jarvis Wu. All rights reserved.
//

import UIKit
import TinyConstraints

protocol DropShadowView {
  func addShadow()
}

class DuolingoButton: UIButton, DropShadowView {
  
  let ui = DuoUI.shared
  var background = UIView()
  var backgroundBottomToSuperview: NSLayoutConstraint!
  let duoBlue = UIColor(red: 27/255, green: 177/255, blue: 247/255, alpha: 1) // in case we need it
  var mainColor = UIColor(red: 151/255, green: 117/255, blue: 250/255, alpha: 1) {
    didSet {
      // set different color for white button
      addShadow()
      shadowColor = mainColor.dimmed(by: 1 - ui.DUO_BUTTON_DIM_RATIO)!
    }
  }
  var shadowColor: UIColor {
    get { return mainColor.dimmed(by: 1 - ui.DUO_BUTTON_DIM_RATIO)! } set {}
  }
  var heightConstraint: NSLayoutConstraint!
  

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    setTitleColor(.white, for: .normal)
    let fontSize: CGFloat = ui.DUO_BUTTON_FONT_SIZE
    let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
    let font: UIFont
    if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
      font = UIFont(descriptor: descriptor, size: fontSize)
    } else {
      font = systemFont
    }
    titleLabel?.font = font
    titleLabel?.centerYToSuperview(offset: -ui.DUO_BUTTON_DROP_SHADOW_HEIGHT / 2)
    setTitle("shadowed button".uppercased(), for: .normal)
    layer.cornerRadius = ui.DUO_BUTTON_CORNER_RADIUS
    heightConstraint = height(ui.DUO_BUTTON_HEIGHT, isActive: true)
    
    addShadow()
  }
  
  func addShadow() {
    backgroundColor = shadowColor
    self.insertSubview(background, at: 0)
    background.isUserInteractionEnabled = false
    background.layer.cornerRadius = self.layer.cornerRadius
    background.backgroundColor = mainColor
    background.edgesToSuperview(excluding: [.bottom])
    backgroundBottomToSuperview = background.bottomToSuperview(offset: -ui.DUO_BUTTON_DROP_SHADOW_HEIGHT)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.layer.removeAllAnimations()
    // TODO: it's not animated
    UIView.animate(withDuration: 0.2) {
      self.heightConstraint.isActive = false
      self.backgroundBottomToSuperview.isActive = false
      self.heightConstraint = self.height(self.ui.DUO_BUTTON_HEIGHT - self.ui.DUO_BUTTON_DROP_SHADOW_HEIGHT, isActive: true)
      self.backgroundBottomToSuperview = self.background.bottomToSuperview()
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    self.layer.removeAllAnimations()
    UIView.animate(withDuration: 0.2) {
      self.heightConstraint.isActive = false
      self.backgroundBottomToSuperview.isActive = false
      self.heightConstraint = self.height(self.ui.DUO_BUTTON_HEIGHT, isActive: true)
      self.backgroundBottomToSuperview = self.background.bottomToSuperview(offset: -self.ui.DUO_BUTTON_DROP_SHADOW_HEIGHT)
    }
  }

}
