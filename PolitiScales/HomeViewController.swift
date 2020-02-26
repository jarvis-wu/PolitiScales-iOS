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
        addConstraints()
    }
    
    private func setNavBar() {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "PolitiScales"
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
        let settingsButton = UIButton()
        let settingsIcon = UIImage(named: "gear")?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(settingsIcon, for: .normal)
        settingsButton.tintColor = .lightGray
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        self.navigationItem.rightBarButtonItem?.customView?.height(20)
        self.navigationItem.rightBarButtonItem?.customView?.aspectRatio(1)
        let shareButton = UIButton()
        let shareIcon = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)
        shareButton.setImage(shareIcon, for: .normal)
        shareButton.tintColor = .lightGray
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.leftBarButtonItem?.customView?.height(20)
        self.navigationItem.leftBarButtonItem?.customView?.aspectRatio(1)
        if let bounds = self.navigationController?.navigationBar.bounds {
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 5)
        }
    }
    
    private func addSubviews() {
        addBottomView()
        self.view.addSubview(navBarSeparator)
        startButton.setTitle("START THE TEST", for: .normal)
        startButton.isUserInteractionEnabled = true
        startButton.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
    }
    
    private func addConstraints() {
        startButton.centerXToSuperview()
        startButton.bottomToSuperview(offset: -30, usingSafeArea: true)
        startButton.leadingToSuperview(offset: 30)
        navBarSeparator.topToSuperview()
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
    
    @objc func didTapSettingsButton() {
        print("open settings")
    }
    
    @objc func didTapShareButton() {
        print("open share")
    }

}
