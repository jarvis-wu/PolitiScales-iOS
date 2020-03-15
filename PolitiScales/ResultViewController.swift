//
//  ResultViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-05.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var ui = DuoUI.shared
    let hapticGenerator = UISelectionFeedbackGenerator()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bottomView = UIView()
    let navBarSeparator = DuolingoSeparator()
    var goHomeButton = DuolingoButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        addSubviews()
        addConstraints()
    }
    
    private func setNavBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Your results"
        let shareButton = UIButton()
        let shareIcon = UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)
        shareButton.setImage(shareIcon, for: .normal)
        shareButton.tintColor = .lightGray
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        self.navigationItem.rightBarButtonItem?.customView?.height(20)
        self.navigationItem.rightBarButtonItem?.customView?.aspectRatio(1)
        self.view.addSubview(navBarSeparator)
    }
    
    private func addSubviews() {
        addBottomView()
        addScrollView()
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.addSubview(goHomeButton)
        let separator = DuolingoSeparator()
        bottomView.addSubview(separator)
        separator.topToSuperview()
        goHomeButton.setTitle("Return to home", for: .normal)
        goHomeButton.isUserInteractionEnabled = true
        goHomeButton.addTarget(self, action: #selector(self.didTapGoHomeButton), for: .touchUpInside)
    }
    
    private func addConstraints() {
        goHomeButton.centerXToSuperview()
        goHomeButton.bottomToSuperview(offset: -25, usingSafeArea: true)
        goHomeButton.leadingToSuperview(offset: 30)
        navBarSeparator.topToSuperview()
        bottomView.topToBottom(of: goHomeButton, offset: -75)
        bottomView.widthToSuperview()
        bottomView.bottomToSuperview()
        self.view.bringSubviewToFront(bottomView)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.edgesToSuperview(excluding: [.bottom])
        scrollView.bottomToTop(of: bottomView)
        scrollView.alwaysBounceVertical = true
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
    }
    
    @objc func didTapGoHomeButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didTapShareButton() {
        print("Share tapped")
    }
    
}
