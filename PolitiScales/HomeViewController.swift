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
    
    // TODO: refactor duplicated code for three cards
    // TODO: embed three cards into a stack view in a scroll view
    
    let titleLabel = DuolingoTitleLabel()
    
    let card1 = DuolingoBorderedCard()
    let card1Icon = UIImageView()
    let card1RightStack = UIStackView()
    let card1Label = DuolingoLabel()
    
    let card2 = DuolingoBorderedCard()
    let card2Icon = UIImageView()
    let card2RightStack = UIStackView()
    let card2Label = DuolingoLabel()
    
    let card3 = DuolingoBorderedCard()
    let card3Icon = UIImageView()
    let card3RightStack = UIStackView()
    let card3Label = DuolingoLabel()
    
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
        self.view.addSubview(navBarSeparator)
    }
    
    private func addSubviews() {
        addBottomView()
        addTitle()
        addCards()
    }
    
    private func addTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.text = "Welcome to PolitiScales."
    }
    
    private func addConstraints() {
        startButton.centerXToSuperview()
        startButton.bottomToSuperview(offset: -30, usingSafeArea: true)
        startButton.leadingToSuperview(offset: 30)
        navBarSeparator.topToSuperview()
        bottomView.topToBottom(of: startButton, offset: -80)
        bottomView.widthToSuperview()
        bottomView.bottomToSuperview()
        
        titleLabel.topToSuperview(offset: 30)
        titleLabel.leadingToSuperview(offset: 30)
        
        card1.topToBottom(of: titleLabel, offset: 20)
        card1.centerXToSuperview()
        card1.leadingToSuperview(offset: 30)
        card1.bottom(to: card1Label, offset: 30)
        card1Icon.height(80)
        card1Icon.aspectRatio(1)
        card1Icon.leadingToSuperview(offset: 20)
        card1Icon.topToSuperview(offset: 20)
        card1RightStack.top(to: card1Icon)
        card1RightStack.trailingToSuperview(offset: 20)
        card1RightStack.leadingToTrailing(of: card1Icon, offset: 20)
        
        card2.topToBottom(of: card1, offset: 20)
        card2.centerXToSuperview()
        card2.leadingToSuperview(offset: 30)
        card2.bottom(to: card2Label, offset: 30)
        card2Icon.height(80)
        card2Icon.aspectRatio(1)
        card2Icon.leadingToSuperview(offset: 20)
        card2Icon.topToSuperview(offset: 20)
        card2RightStack.top(to: card2Icon)
        card2RightStack.trailingToSuperview(offset: 20)
        card2RightStack.leadingToTrailing(of: card2Icon, offset: 20)
        
        card3.topToBottom(of: card2, offset: 20)
        card3.centerXToSuperview()
        card3.leadingToSuperview(offset: 30)
        card3.bottom(to: card3Label, offset: 30)
        card3Icon.height(80)
        card3Icon.aspectRatio(1)
        card3Icon.leadingToSuperview(offset: 20)
        card3Icon.topToSuperview(offset: 20)
        card3RightStack.top(to: card3Icon)
        card3RightStack.trailingToSuperview(offset: 20)
        card3RightStack.leadingToTrailing(of: card3Icon, offset: 20)
        
        self.view.bringSubviewToFront(bottomView)
    }
    
    private func addCards() {
        card1.addSubview(card1Icon)
        card1.addSubview(card1RightStack)
        card1RightStack.axis = .vertical
        card1RightStack.distribution = .equalCentering
        card1RightStack.spacing = 12
        card1RightStack.addArrangedSubview(card1Label)
        card1Icon.image = UIImage(named: "question")
        card1Label.numberOfLines = 0
        card1Label.text = "The questions you are going to answer assume that your are a citizen of a multi-parti political system and a market economy."
        self.view.addSubview(card1)
        
        card2.addSubview(card2Icon)
        card2.addSubview(card2RightStack)
        card2RightStack.axis = .vertical
        card2RightStack.distribution = .equalCentering
        card2RightStack.spacing = 12
        card2RightStack.addArrangedSubview(card2Label)
        card2Icon.image = UIImage(named: "dream")
        card2Label.numberOfLines = 0
        card2Label.text = "You can always avoid answering a question. But if you do not understand the meaning of one of them, try to invert its meaning for a better understanding of what is implied."
        self.view.addSubview(card2)
        
        card3.addSubview(card3Icon)
        card3.addSubview(card3RightStack)
        card3RightStack.axis = .vertical
        card3RightStack.distribution = .equalCentering
        card3RightStack.spacing = 12
        card3RightStack.addArrangedSubview(card3Label)
        card3Icon.image = UIImage(named: "pride")
        card3Label.numberOfLines = 0
        card3Label.text = "This test tries to represent the wider set of ideas as possible and contains some phrases that can be shocking, notably concerning racism and homosexuality."
        self.view.addSubview(card3)
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.addSubview(startButton)
        let separator = DuolingoSeparator()
        bottomView.addSubview(separator)
        separator.topToSuperview()
        startButton.setTitle("Start the test", for: .normal)
        startButton.isUserInteractionEnabled = true
        startButton.addTarget(self, action: #selector(self.didTapStartButton), for: .touchUpInside)
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
