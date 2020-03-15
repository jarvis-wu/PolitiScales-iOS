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
    var resultLabel = DuolingoLabel()
    var results: [String : (Int, Int)]!
    
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
        addResultLabel()
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
        resultLabel.leadingToSuperview(offset: 30)
        resultLabel.trailingToSuperview(offset: 30)
        resultLabel.top(to: contentView, offset: 25)
        resultLabel.bottom(to: contentView, offset: -30)
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
    
    private func addResultLabel() {
        self.view.addSubview(resultLabel)
        resultLabel.numberOfLines = 0
        resultLabel.font = resultLabel.font.withSize(12)
        resultLabel.text = """
        Constructivism \(results["c"]!.0) : Neutral \(100 - results["c"]!.0 - results["c"]!.1) : Essentialism \(results["c"]!.1)
        \(String(repeating: "▒", count: results["c"]!.0 ))\(String(repeating: "░", count: 100 - results["c"]!.0 - results["c"]!.1))\(String(repeating: "▓", count: results["c"]!.1))\n
        Rehabilitative justice \(results["j"]!.0) : Neutral \(100 - results["j"]!.0 - results["j"]!.1) : Punitive justice \(results["j"]!.1)
        \(String(repeating: "▒", count: results["j"]!.0 ))\(String(repeating: "░", count: 100 - results["j"]!.0 - results["j"]!.1))\(String(repeating: "▓", count: results["j"]!.1))\n
        Progressism \(results["s"]!.0) : Neutral \(100 - results["s"]!.0 - results["s"]!.1) : Conservatism \(results["s"]!.1)
        \(String(repeating: "▒", count: results["s"]!.0))\(String(repeating: "░", count: 100 - results["s"]!.0 - results["s"]!.1))\(String(repeating: "▓", count: results["s"]!.1))\n
        Internationalism \(results["b"]!.0) : \(100 - results["b"]!.0 - results["b"]!.1) : Nationalism \(results["b"]!.1)
        \(String(repeating: "▒", count: results["b"]!.0))\(String(repeating: "░", count: 100 - results["b"]!.0 - results["b"]!.1))\(String(repeating: "▓", count: results["b"]!.1))\n
        Communism \(results["p"]!.0) : Neutral \(100 - results["p"]!.0 - results["p"]!.1) : Capitalism \(results["p"]!.1)
        \(String(repeating: "▒", count: results["p"]!.0))\(String(repeating: "░", count: 100 - results["p"]!.0 - results["p"]!.1))\(String(repeating: "▓", count: results["p"]!.1))\n
        Regulationism \(results["m"]!.0) : Neutral \(100 - results["m"]!.0 - results["m"]!.1) : Laissez-faire \(results["m"]!.1)
        \(String(repeating: "▒", count: results["m"]!.0))\(String(repeating: "░", count: 100 - results["m"]!.0 - results["m"]!.1))\(String(repeating: "▓", count: results["m"]!.1))\n
        Ecology \(results["e"]!.0) : Neutral \(100 - results["e"]!.0 - results["e"]!.1) : Productivism \(results["e"]!.1)
        \(String(repeating: "▒", count: results["e"]!.0))\(String(repeating: "░", count: 100 - results["e"]!.0 - results["e"]!.1))\(String(repeating: "▓", count: results["e"]!.1))\n
        Revolution \(results["t"]!.0) : Neutral \(100 - results["t"]!.0 - results["t"]!.1) : Reformism \(results["t"]!.1)
        \(String(repeating: "▒", count: results["t"]!.0))\(String(repeating: "░", count: 100 - results["t"]!.0 - results["t"]!.1))\(String(repeating: "▓", count: results["t"]!.1))\n
        Feminism \(results["femi"]!.0) : Non-Feminism \(results["femi"]!.1)
        \(String(repeating: "▓", count: results["femi"]!.0 ))\(String(repeating: "░", count: results["femi"]!.1))\n
        Missionary \(results["reli"]!.0) : Non-Missionary \(results["reli"]!.1)
        \(String(repeating: "▓", count: results["reli"]!.0))\(String(repeating: "░", count: results["reli"]!.1))\n
        Complotism \(results["comp"]!.0) : Non-Complotism \(results["comp"]!.1)
        \(String(repeating: "▓", count: results["comp"]!.0))\(String(repeating: "░", count: results["comp"]!.1))\n
        Pragmatism \(results["prag"]!.0) : Non-Pragmatism \(results["prag"]!.1)
        \(String(repeating: "▓", count: results["prag"]!.0))\(String(repeating: "░", count: results["prag"]!.1))\n
        Monarchism \(results["mona"]!.0) : Non-Monarchism \(results["mona"]!.1)
        \(String(repeating: "▓", count: results["mona"]!.0))\(String(repeating: "░", count: results["mona"]!.1))\n
        Veganism \(results["vega"]!.0) : Non-Veganism \(results["vega"]!.1)
        \(String(repeating: "▓", count: results["vega"]!.0))\(String(repeating: "░", count: results["vega"]!.1))\n
        Anarchism \(results["anar"]!.0) : Non-Anarchism \(results["anar"]!.1)
        \(String(repeating: "▓", count: results["anar"]!.0))\(String(repeating: "░", count: results["anar"]!.1))\n
        """
    }
    
    @objc func didTapGoHomeButton() {
        tryGenerateSelectionChangedHaptic()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func didTapShareButton() {
        print("Share tapped")
        tryGenerateSelectionChangedHaptic()
        self.showAlert(withTitle: "Oops", message: "Share is not available yet.")
    }
    
    // TODO: how to refactor this?
    private func tryGenerateSelectionChangedHaptic() {
        if UserDefaults.standard.bool(forKey: "hapticEffectOn") {
            hapticGenerator.selectionChanged()
        }
    }
    
}
