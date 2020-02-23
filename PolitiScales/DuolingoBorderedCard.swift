//
//  DuolingoBorderedCard.swift
//  DuoUI
//
//  Created by Jarvis Wu on 2/14/20.
//  Copyright © 2020 Jarvis Wu. All rights reserved.
//

import UIKit

class DuolingoBorderedCard: UIView {

  let ui = DuoUI.shared
  
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
    layer.cornerRadius = ui.DUO_BORDERED_CARD_CORNER_RADIUS
    layer.borderColor = ui.DUO_BORDERED_CARD_BORDER_COLOR
    layer.borderWidth = ui.DUO_BORDERED_CARD_BORDER_WIDTH
//    heightConstraint = height(ui.DUO_BORDERED_CARD_HEIGHT, isActive: true)
  }


}
