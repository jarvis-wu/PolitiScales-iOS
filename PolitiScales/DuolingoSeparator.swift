//
//  DuolingoSeparator.swift
//  DuoUI
//
//  Created by Jarvis Wu on 2/14/20.
//  Copyright © 2020 Jarvis Wu. All rights reserved.
//

import UIKit

class DuolingoSeparator: UIView {
  
  let ui = DuoUI.shared

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    backgroundColor = ui.DUO_SEPARATOR_COLOR
    height(ui.DUO_SEPARATOR_HEIGHT)
  }
  
  override func didMoveToSuperview() {
    if let _ = superview {
      widthToSuperview()
      centerXToSuperview()
    }
  }

}
