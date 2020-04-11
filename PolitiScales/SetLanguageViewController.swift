//
//  SetLanguageViewController.swift
//  PolitiScales
//
//  Created by Jarvis Wu on 4/9/20.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

protocol SetLanguageViewControllerDelegate {
    func didUpdateLanguage()
}

class SetLanguageViewController: UIViewController, SetLanguageViewDelegate {

    var ui = DuoUI.shared
    var delegate: SetLanguageViewControllerDelegate!
    let hapticGenerator = UISelectionFeedbackGenerator()
    let navBarSeparator = DuolingoSeparator()
    let setLanguageView = SetLanguageView()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bottomView = UIView()
    let doneButton = DuolingoButton()
    var currentSelectedLanguageCode = UserDefaults.standard.string(forKey: "language") ?? "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavBar()
        addSubviews()
        addConstraints()
    }
    
    private func setNavBar() {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Choose Language"
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
        navigationController?.navigationBar.isTranslucent = false
        let exitButton = UIButton()
        let exitIcon = UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate)
        exitButton.setImage(exitIcon, for: .normal)
        exitButton.tintColor = .lightGray
        exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: exitButton)
        self.navigationItem.leftBarButtonItem?.customView?.height(20)
        self.navigationItem.leftBarButtonItem?.customView?.aspectRatio(1)
        if let bounds = self.navigationController?.navigationBar.bounds {
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 5)
        }
        self.view.addSubview(navBarSeparator)
    }
    
    private func addSubviews() {
        addBottomView()
        addScrollView()
        addRows()
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
    
    private func addRows() {
        contentView.addSubview(setLanguageView)
        setLanguageView.delegate = self
        let model = SetLanguageModel()
        var rows = [UIView]()
        for language in model.languages {
            let languageRow = SetLanguageRowView(withData: language, isSelected: model.currentLanguageCode == language.2) {
            }
            rows.append(languageRow)
        }
        setLanguageView.addRowsWithSeparators(rows: rows)
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.addSubview(doneButton)
        let separator = DuolingoSeparator()
        bottomView.addSubview(separator)
        separator.topToSuperview()
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(self.didTapDoneButton), for: .touchUpInside)
    }
    
    private func addConstraints() {
        doneButton.centerXToSuperview()
        doneButton.bottomToSuperview(offset: -25, usingSafeArea: true)
        doneButton.leadingToSuperview(offset: 30)
        navBarSeparator.topToSuperview()
        bottomView.topToBottom(of: doneButton, offset: -75)
        bottomView.edgesToSuperview(excluding: [.top])
        
        setLanguageView.leadingToSuperview(offset: 30)
        setLanguageView.trailingToSuperview(offset: 30)
        setLanguageView.top(to: contentView, offset: 30)
        setLanguageView.bottom(to: contentView, offset: -30)
        
        self.view.bringSubviewToFront(bottomView)
    }
    
    @objc func didTapDoneButton() {
        tryGenerateSelectionChangedHaptic()
        dismiss(animated: true) {
            let selectedLanguage = SetLanguageModel().languages.first { $0.2 == self.currentSelectedLanguageCode }!
            print("Updating language to \(selectedLanguage.0).")
            UserDefaults.standard.set(selectedLanguage.2, forKey: "language")
            self.delegate.didUpdateLanguage()
        }
    }
    
    @objc func didTapExit() {
        tryGenerateSelectionChangedHaptic()
        dismiss(animated: true)
    }
    
    func didSelectLanguage(withCode code: String) {
        currentSelectedLanguageCode = code
    }
    
    private func tryGenerateSelectionChangedHaptic() {
        if UserDefaults.standard.bool(forKey: "hapticEffectOn") {
            hapticGenerator.selectionChanged()
        }
    }

}

protocol SetLanguageViewDelegate {
    func didSelectLanguage(withCode code: String)
}

class SetLanguageView: UIView {
    
    var delegate: SetLanguageViewDelegate!
    
    private var rowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let card = DuolingoBorderedCard()
        self.addSubview(card)
        card.edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        card.addSubview(rowStack)
        // By this the card height will grow automatically as we insert rows
        let borderWidth = DuoUI.shared.DUO_BORDERED_CARD_BORDER_WIDTH // Constrain the top/bottom of stack to inner side of card border
        rowStack.edgesToSuperview(insets: UIEdgeInsets(top: borderWidth, left: 0, bottom: borderWidth, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addRowsWithSeparators(rows: [UIView]) {
        for (index, row) in rows.enumerated() {
            addRow(subview: row)
            if index != rows.count - 1 {
                addRow(subview: DuolingoSeparator())
            }
        }
    }
    
    private func addRow(subview: UIView) {
        rowStack.addArrangedSubview(subview)
        (subview as? SetLanguageRowView)?.setLanguageView = self
    }
    
    func didSelectRow(withCode code: String) {
        for view in rowStack.arrangedSubviews {
            (view as? SetLanguageRowView)?.selectedIndicator.isHidden = true
        }
        delegate.didSelectLanguage(withCode: code)
    }
    
}

class SetLanguageRowView: UIView {
    
    var setLanguageView: SetLanguageView!
    var code: String!
    let titleLabel = DuolingoLabel()
    let flagImageView = UIImageView()
    let selectedIndicator = UIImageView()
    var didTap: (() -> Void)!
    
    init(withData data: (displayingName: String, imageName: String, code: String), isSelected: Bool, didTap: @escaping () -> Void) {
        super.init(frame: .zero)
        height(DuoUI.shared.SettingsRowHeight)
        flagImageView.image = UIImage(named: data.imageName)
        addSubview(flagImageView)
        flagImageView.layer.cornerRadius = 10
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.clipsToBounds = true
        flagImageView.centerYToSuperview()
        flagImageView.leadingToSuperview(offset: 10)
        flagImageView.topToSuperview(offset: 5)
        flagImageView.aspectRatio(4.0 / 3.0)
        titleLabel.text = data.displayingName
        addSubview(titleLabel)
        titleLabel.centerYToSuperview()
        titleLabel.leadingToTrailing(of: flagImageView, offset: 10)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        selectedIndicator.image = UIImage(named: "tick")?.withRenderingMode(.alwaysTemplate)
        selectedIndicator.tintColor = UIColor(red: 151/255, green: 117/255, blue: 250/255, alpha: 1)
        addSubview(selectedIndicator)
        selectedIndicator.height(20)
        selectedIndicator.aspectRatio(1)
        selectedIndicator.trailingToSuperview(offset: 20)
        selectedIndicator.centerYToSuperview()
        selectedIndicator.isHidden = !isSelected
        self.didTap = didTap
        self.code = data.code
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRow)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapRow() {
        setLanguageView.didSelectRow(withCode: code)
        selectedIndicator.isHidden = false
        didTap()
    }
    
}

class SetLanguageModel {
    
    var currentLanguageCode: String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "language") ?? "en"
    }
    
    let languages = [("English", "flag-us", "en"),
                     ("简体中文", "flag-china", "zhs"),
                     ("繁體中文", "flag-taiwan", "zht"),
                     ("Deutsch", "flag-germany", "de"),
                     ("Español", "flag-spain", "es"),
                     ("Filipino", "flag-philippines", "fil"),
                     ("Français", "flag-france", "fr"),
                     ("Italiano", "flag-italy", "it"),
                     ("Norsk", "flag-norway", "no"),
                     ("Polski", "flag-poland", "pl"),
                     ("Português", "flag-brazil", "pt"),
                     ("Türkçe", "flag-turkey", "tr"),
                     ("Русский", "flag-russia", "ru"),
                     ("العربية", "flag-saudi", "ar")]
    
}
