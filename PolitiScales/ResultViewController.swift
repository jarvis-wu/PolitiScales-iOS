//
//  ResultViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-05.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

struct ResultValues: Codable {
    var l: Int
    var r: Int
    
    init(_ l: Int, _ r: Int) {
        self.l = l
        self.r = r
    }
}

class ResultViewController: UIViewController {

    var ui = DuoUI.shared
    let hapticGenerator = UISelectionFeedbackGenerator()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bottomView = UIView()
    let navBarSeparator = DuolingoSeparator()
    var goHomeButton = DuolingoButton()
    var resultStackView = UIStackView()
    var qrCodeView = UIImageView()
    
    var results: [String : ResultValues]! {
        didSet {
            setupResultStackView()
        }
    }
    
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
        addResultStackView()
        addQRCodeView()
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
    
    private func addQRCodeView() {
        view.addSubview(qrCodeView)
        let encoder = JSONEncoder()
        // TODO: maybe we should encode in a simpler way?
        if let encoded = try? encoder.encode(results) {
            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(encoded, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 5, y: 5)
                if let output = filter.outputImage?.transformed(by: transform) {
                    qrCodeView.image = UIImage(ciImage: output)
                }
            }
        }
    }
    
    private func addConstraints() {
        goHomeButton.centerXToSuperview()
        goHomeButton.bottomToSuperview(offset: -25, usingSafeArea: true)
        goHomeButton.leadingToSuperview(offset: 30)
        navBarSeparator.topToSuperview()
        bottomView.topToBottom(of: goHomeButton, offset: -75)
        bottomView.widthToSuperview()
        bottomView.bottomToSuperview()
        resultStackView.leadingToSuperview(offset: 30)
        resultStackView.trailingToSuperview(offset: 30)
        resultStackView.top(to: contentView, offset: 25)
        resultStackView.bottomToTop(of: qrCodeView, offset: -25)
        qrCodeView.height(200)
        qrCodeView.aspectRatio(1)
        qrCodeView.centerXToSuperview()
        qrCodeView.bottom(to: contentView, offset: -30)
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
    
    private func addResultStackView() {
        self.view.addSubview(resultStackView)
        resultStackView.isUserInteractionEnabled = false
        resultStackView.axis = .vertical
        resultStackView.spacing = 10
    }
    
    private func setupResultStackView() {
        let orderedMainKeys = ["c", "j", "s", "b", "p", "m", "e", "t"]
        // TODO
//        let orderedBonusKeys = ["femi", "reli", "comp", "prag", "mona", "vega", "anar"]
        for key in orderedMainKeys {
            resultStackView.addArrangedSubview(ResultRowView(resultItem: ResultItem(values: results[key]!,
                                                                                    leftTitle: leftAxisTitle(for: key)!,
                                                                                    rightTitle: rightAxisTitle(for: key)!,
                                                                                    leftColor: leftAxisColor(for: key)!,
                                                                                    rightColor: rightAxisColor(for: key)!,
                                                                                    leftIcon: leftAxisImage(for: key)!,
                                                                                    rightIcon: rightAxisImage(for: key)!)))
        }
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

class ResultRowView: UIView {
    
    var titleStack = UIStackView()
    var barView = UIView()
    var leftIcon = UIImageView()
    var rightIcon = UIImageView()
    var leftProgress = OneSideProgressView(side: OneSideProgressView.Side.left)
    var rightProgress = OneSideProgressView(side: OneSideProgressView.Side.right)
    var leftNumberLabel = UILabel()
    var rightNumberLabel = UILabel()
    var neutralNumberLabel = UILabel()
    
    init(resultItem: ResultItem) {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        titleStack.axis = .horizontal
        titleStack.distribution = .equalSpacing
        let leftTitleLabel = DuolingoLabel()
        leftTitleLabel.text = resultItem.leftTitle
        let rightTitleLabel = DuolingoLabel()
        rightTitleLabel.text = resultItem.rightTitle
        titleStack.addArrangedSubview(leftTitleLabel)
        titleStack.addArrangedSubview(rightTitleLabel)
        self.addSubview(titleStack)
        titleStack.edgesToSuperview(excluding: [.bottom])
        barView.backgroundColor = DuoUI.shared.DUO_PROGRESS_DEFAULT_TRACK_COLOR
        barView.height(30)
        self.addSubview(barView)
        barView.bottomToSuperview(offset: -10)
        barView.leadingToSuperview(offset: 30)
        barView.trailingToSuperview(offset: 30)
        barView.topToBottom(of: titleStack, offset: 10)
        self.addSubview(leftIcon)
        leftIcon.height(40)
        leftIcon.layer.cornerRadius = 40 / 2
        leftIcon.aspectRatio(1)
        leftIcon.image = resultItem.leftIcon
        leftIcon.centerY(to: barView)
        leftIcon.leadingToSuperview()
        self.addSubview(rightIcon)
        rightIcon.height(40)
        rightIcon.layer.cornerRadius = 40 / 2
        rightIcon.aspectRatio(1)
        rightIcon.image = resultItem.rightIcon
        rightIcon.centerY(to: barView)
        rightIcon.trailingToSuperview()
        barView.addSubview(leftProgress)
        leftProgress.backgroundColor = resultItem.leftColor
        leftProgress.widthToSuperview(multiplier: CGFloat(resultItem.values.l) / CGFloat(100)) // TODO: animate progress?
        leftProgress.edgesToSuperview(excluding: [.trailing])
        barView.addSubview(rightProgress)
        rightProgress.backgroundColor = resultItem.rightColor
        rightProgress.widthToSuperview(multiplier: CGFloat(resultItem.values.r) / CGFloat(100)) // TODO: animate progress?
        rightProgress.edgesToSuperview(excluding: [.leading])
        leftProgress.addSubview(leftNumberLabel)
        leftNumberLabel.text = "\(resultItem.values.l)%"
        leftNumberLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        leftNumberLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        leftNumberLabel.centerYToSuperview()
        leftNumberLabel.trailingToSuperview(offset: 10)
        rightProgress.addSubview(rightNumberLabel)
        rightNumberLabel.text = "\(resultItem.values.r)%"
        rightNumberLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        rightNumberLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        rightNumberLabel.centerYToSuperview()
        rightNumberLabel.leadingToSuperview(offset: 10)
        barView.addSubview(neutralNumberLabel)
        neutralNumberLabel.text = "\(100 - resultItem.values.l - resultItem.values.r)%"
        neutralNumberLabel.textColor = UIColor.black.withAlphaComponent(0.25)
        neutralNumberLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        neutralNumberLabel.centerYToSuperview()
        neutralNumberLabel.centerXToSuperview(multiplier: ((100 - CGFloat(resultItem.values.l) - CGFloat(resultItem.values.r)) / 2 + CGFloat(resultItem.values.l)) / 100 * 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class OneSideProgressView: UIView {
    
    var side: Side
    
    enum Side {
        case left
        case right
    }
    
    init(side: Side) {
        self.side = side
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch side {
        case .left:
            self.roundCorners(corners: [.topRight, .bottomRight], radius: 30 / 2)
        case .right:
            self.roundCorners(corners: [.topLeft, .bottomLeft], radius: 30 / 2)
        }
    }
    
}

struct ResultItem {
    
    var values: ResultValues
    var leftTitle: String
    var rightTitle: String
    var leftColor: UIColor
    var rightColor: UIColor
    var leftIcon: UIImage
    var rightIcon: UIImage
    
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
