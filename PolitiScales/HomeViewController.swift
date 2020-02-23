//
//  HomeViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-03.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit
import TinyConstraints

class HomeViewController: UIViewController {

    var ui = DuoUI.shared
    let startButton = DuolingoButton()
    let bottomView = UIView()
    let navBarSeparator = DuolingoSeparator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        addSubviews()
        setSubviews()
        addConstraints()
    }
    
    private func setNavBar() {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        let fontSize: CGFloat = ui.DUO_TITLE_LABEL_FONT_SIZE
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        let font: UIFont
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
          font = UIFont(descriptor: descriptor, size: fontSize)
        } else {
          font = systemFont
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                                   NSAttributedString.Key.font: font]
    }
    
    private func addSubviews() {
        addBottomView()
        self.view.addSubview(navBarSeparator)
    }
    
    private func setSubviews() {
        startButton.setTitle("START THE TEST", for: .normal)
        startButton.isUserInteractionEnabled = true
        startButton.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
    }
    
    private func addConstraints() {
        startButton.centerXToSuperview()
        startButton.bottomToSuperview(offset: -30, usingSafeArea: true)
        startButton.leadingToSuperview(offset: 30)
        navBarSeparator.topToSuperview(offset: 5)
        bottomView.topToBottom(of: startButton, offset: -80)
        bottomView.widthToSuperview()
        bottomView.bottomToSuperview()
    }
    
    func addBottomView() {
      view.addSubview(bottomView)
      bottomView.addSubview(startButton)
      let separator = DuolingoSeparator()
      bottomView.addSubview(separator)
      separator.topToSuperview()
    }
    
    @objc func didTapStartButton() {
        performSegue(withIdentifier: "ShowQuiz", sender: self)
    }

}
