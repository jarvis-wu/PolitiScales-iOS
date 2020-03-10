//
//  DuolingoExtensions.swift
//  DuoUI
//
//  Created by Jarvis Wu on 2/14/20.
//  Copyright © 2020 Jarvis Wu. All rights reserved.
//

import Foundation
import UIKit

class DuoUI {
  
  static let shared = DuoUI()
  
  // DuoProgressView
  let DUO_PROGRESS_VIEW_DEFAULT_HEIGHT: CGFloat = 20
  let DUO_PROGRESS_DEFAULT_TRACK_COLOR = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
  let DUO_PROGRESS_DEFAULT_PROGRESS_COLOR = UIColor(red: 255/255, green: 200/255, blue: 0/255, alpha: 1)
  var DUO_PROGRESS_DEFAULT_PROGRESS_HIGHLIGHT: UIColor {
    return DUO_PROGRESS_DEFAULT_PROGRESS_COLOR.dimmed(by: -0.05) ?? .white
  }
  
  // DuoBorderedCard
  let DUO_BORDERED_CARD_CORNER_RADIUS: CGFloat = 15
  let DUO_BORDERED_CARD_BORDER_WIDTH: CGFloat = 2
  let DUO_BORDERED_CARD_HEIGHT: CGFloat = 100
  let DUO_BORDERED_CARD_BORDER_COLOR = UIColor(white: 0.9, alpha: 1).cgColor
  
  // DuoShadowedCard
  let DUO_SHADOWED_CARD_CORNER_RADIUS: CGFloat = 15
  let DUO_SHADOWED_CARD_DROP_SHADOW_HEIGHT: CGFloat = 4
  let DUO_SHADOWED_CARD_HEIGHT: CGFloat = 100
  let DUO_SHADOWED_CARD_DIM_RATIO: CGFloat = 0.83
  
  // DuoSeparator
  let DUO_SEPARATOR_COLOR = UIColor(white: 0.9, alpha: 1)
  let DUO_SEPARATOR_HEIGHT: CGFloat = 2
  
  // DuoLabel
  let DUO_LABEL_TEXT_COLOR = UIColor.gray
  let DUO_LABEL_DEFAULT_TEXT = "This is just a plain normal label"
  let DUO_LABEL_FONT_SIZE : CGFloat = 16
  
  // DuoTitleLabel
  let DUO_TITLE_LABEL_TEXT_COLOR = UIColor.black
  let DUO_TITLE_LABEL_DEFAULT_TEXT = "title label".capitalized
  let DUO_TITLE_LABEL_FONT_SIZE : CGFloat = 18
  
  // DuoButton
  let DUO_BUTTON_CORNER_RADIUS: CGFloat = 12
  let DUO_BUTTON_DROP_SHADOW_HEIGHT: CGFloat = 4
  let DUO_BUTTON_HEIGHT: CGFloat = 50
  let DUO_BUTTON_DIM_RATIO: CGFloat = 0.83
  let DUO_BUTTON_FONT_SIZE : CGFloat = 15
  
}

extension UIColor {
  
  func dimmed(by amount: CGFloat) -> UIColor? {
    return adjusted(hueBy: 0, saturationBy: 0, brightnessBy: -amount, alphaBy: 1)
  }
  
  func transparent(by amount: CGFloat) -> UIColor? {
    return adjusted(hueBy: 0, saturationBy: 0, brightnessBy: 0, alphaBy: amount)
  }
  
  func adjusted(hueBy hAmount: CGFloat,
                saturationBy sAmount: CGFloat,
                brightnessBy bAmount: CGFloat,
                alphaBy aAmount: CGFloat) -> UIColor? {
    for amount in [hAmount, sAmount, bAmount] {
      guard amount >= -1 && amount <= 1 else { return nil }
    }
    guard aAmount >= 0 && aAmount <= 1 else { return nil }
    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
      let adjustedColor = UIColor(hue: h * (1 + hAmount), saturation: s * (1 + sAmount), brightness: b * (1 + bAmount), alpha: a * aAmount)
      return adjustedColor
    }
    return nil
  }
}
