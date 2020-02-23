//
//  DuolingoLabel.swift
//  DuoUI
//
//  Created by Jarvis Wu on 2/14/20.
//  Copyright © 2020 Jarvis Wu. All rights reserved.
//

import UIKit

class DuolingoLabel: UILabel {

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
    textColor = ui.DUO_LABEL_TEXT_COLOR
    text = ui.DUO_LABEL_DEFAULT_TEXT.capitalized
    let fontSize: CGFloat = ui.DUO_LABEL_FONT_SIZE
    let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    let font: UIFont
    if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
      font = UIFont(descriptor: descriptor, size: fontSize)
    } else {
      font = systemFont
    }
    self.font = font
  }

}
