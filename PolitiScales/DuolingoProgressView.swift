//
//  DuolingoProgressView.swift
//  DuoUI
//
//  Created by Jarvis Wu on 2/14/20.
//  Copyright © 2020 Jarvis Wu. All rights reserved.
//

import UIKit

class DuolingoProgressView: UIProgressView {
  
  let ui = DuoUI.shared
  
  override var progress: Float {
    didSet {
      guard let _ = tintedProgressWidth, progress != 0 else { return }
      tintedProgressWidth.isActive = false
      DispatchQueue.main.async {
        UIView.animate(withDuration: 0.5) {
          self.tintedProgressWidth = self.tintedProgress.widthToSuperview(multiplier: CGFloat(self.progress))
          self.layoutIfNeeded()
        }
      }
    }
  }
  
  let trackBackgroundView = UIView()
  let tintedProgress = UIView()
  let highlightView = UIView()
  var tintedProgressWidth: NSLayoutConstraint!

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    let height = ui.DUO_PROGRESS_VIEW_DEFAULT_HEIGHT
    clipsToBounds = false
    self.height(height)
    trackTintColor = .clear
    tintColor = .clear
    progress = 0
    
    self.addSubview(trackBackgroundView)
    self.addSubview(tintedProgress)
    tintedProgress.addSubview(highlightView)
    
    trackBackgroundView.edgesToSuperview(excluding: [.top, .bottom])
    trackBackgroundView.height(height)
    trackBackgroundView.centerYToSuperview()
    trackBackgroundView.layer.cornerRadius = height / 2
    trackBackgroundView.backgroundColor = ui.DUO_PROGRESS_DEFAULT_TRACK_COLOR
    
    tintedProgress.edgesToSuperview(excluding: [.top, .bottom, .trailing])
    tintedProgress.height(height)
    tintedProgress.centerYToSuperview()
    tintedProgressWidth = tintedProgress.widthToSuperview(multiplier: CGFloat(self.progress))
    tintedProgress.layer.cornerRadius = height / 2
    tintedProgress.backgroundColor = ui.DUO_PROGRESS_DEFAULT_PROGRESS_COLOR
    
    highlightView.bottom(to: tintedProgress, tintedProgress.centerYAnchor, offset: 1)
    highlightView.height(height / 3)
    highlightView.layer.cornerRadius = (height / 3) / 2
    highlightView.centerXToSuperview()
    highlightView.leadingToSuperview(offset: 5)
    highlightView.backgroundColor = ui.DUO_PROGRESS_DEFAULT_PROGRESS_HIGHLIGHT
  }

}
