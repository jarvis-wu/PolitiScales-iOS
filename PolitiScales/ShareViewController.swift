//
//  ShareViewController.swift
//  PolitiScales
//
//  Created by Jarvis Wu on 4/13/20.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    enum ShareMethod {
        case facebook
        case twitter
        case whatsapp
        case telegram
        case more
    }
    
    let shareMethodsData: [(ShareMethod, String, UIColor)] = [
        (.facebook, "facebook", UIColor(red: 63/255, green: 86/255, blue: 154/255, alpha: 1)),
        (.twitter, "twitter", UIColor(red: 103/255, green: 170/255, blue: 235/255, alpha: 1)),
        (.whatsapp, "whatsapp", UIColor(red: 101/255, green: 210/255, blue: 88/255, alpha: 1)),
        (.telegram, "telegram", UIColor(red: 113/255, green: 167/255, blue: 217/255, alpha: 1)),
        (.more, "more", UIColor(red: 249/255, green: 130/255, blue: 120/255, alpha: 1))
    ]
        
    var results: [String : ResultValues]! {
        didSet {
            //
        }
    }
    
    private var bottomCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private var snapshotPreviewView = UIView()
    private let cancelButton = DuolingoButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        addSubviews()
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bottomCardView.transform = CGAffineTransform(translationX: 0, y: 250)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                self.bottomCardView.transform = .identity
                self.snapshotPreviewView.alpha = 1
            }, completion: nil)
        }
    }
    
    private func addSubviews() {
        addBottomCard()
        addSnapshotPreviewView()
    }
    
    private func addBottomCard() {
        view.addSubview(bottomCardView)
        bottomCardView.addSubview(cancelButton)
        let separator = DuolingoSeparator()
        bottomCardView.addSubview(separator)
        separator.topToSuperview()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(self.didTapView), for: .touchUpInside)
        let titleLabel = DuolingoTitleLabel()
        titleLabel.text = "Share via..."
        titleLabel.textColor = .lightGray
        bottomCardView.addSubview(titleLabel)
        titleLabel.height(25)
        titleLabel.centerXToSuperview()
        titleLabel.topToSuperview(offset: 25)
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 15
        buttonStack.height(60)
        bottomCardView.addSubview(buttonStack)
        buttonStack.topToBottom(of: titleLabel, offset: 25)
        buttonStack.centerXToSuperview()
        for item in shareMethodsData {
            let button = DuolingoButton(color: item.2)
            button.setTitle(nil, for: .normal)
            button.imageView?.bottom(to: button.background, offset: -8)
            button.imageView?.height(40)
            button.imageView?.width(40)
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(UIImage(named: item.1)?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageView?.tintColor = .white
            button.bringSubviewToFront(button.imageView!)
            button.aspectRatio(1)
            button.height(60)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            buttonStack.addArrangedSubview(button)
        }
        
        cancelButton.centerXToSuperview()
        cancelButton.bottomToSuperview(offset: -25, usingSafeArea: true)
        cancelButton.leadingToSuperview(offset: 30)
        bottomCardView.topToBottom(of: cancelButton, offset: -210) // 50 + 25 + 60 + 25 + 25 + 25
        bottomCardView.edgesToSuperview(excluding: [.top])
        view.layoutIfNeeded()
    }
    
    private func addSnapshotPreviewView() {
        view.addSubview(snapshotPreviewView)
        snapshotPreviewView.backgroundColor = .white
        snapshotPreviewView.layer.cornerRadius = 15
        snapshotPreviewView.alpha = 0
    }
    
    private func addConstraints() {
        snapshotPreviewView.edgesToSuperview(excluding: [.bottom], insets: UIEdgeInsets(top: 45, left: 45, bottom: 0, right: 45), usingSafeArea: true)
        snapshotPreviewView.bottomToTop(of: bottomCardView, offset: -40)
    }
    
    @objc func didTapView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.view.backgroundColor = UIColor.clear
                self.bottomCardView.transform = CGAffineTransform(translationX: 0, y: 250)
                self.snapshotPreviewView.alpha = 0
            }, completion: { (_) in
                self.dismiss(animated: false, completion: nil)
            })
        }
    }

}
