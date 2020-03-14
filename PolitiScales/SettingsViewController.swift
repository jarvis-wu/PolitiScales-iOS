//
//  SettingsViewController.swift
//  PolitiScales
//
//  Created by Jarvis Wu on 3/8/20.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    /*
     Settings items"
     
     - Debug
         - "isDebugActivated"
         - "shouldShowSimulationButton"
         - "shouldShowQuestionsUnshuffled"
    */
    
    enum SettingsSections: String, CaseIterable {
        case general = "General"
        case debug = "Debug"
    }

    let defaults = UserDefaults.standard
    let hapticGenerator = UISelectionFeedbackGenerator()
    let navBarSeparator = DuolingoSeparator()
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavBar()
        addTableView()
        addConstraints()
    }
    
    private func setNavBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Settings"
        let exitButton = UIButton()
        let exitIcon = UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate)
        exitButton.setImage(exitIcon, for: .normal)
        exitButton.tintColor = .lightGray
        exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: exitButton)
        self.navigationItem.leftBarButtonItem?.customView?.height(20)
        self.navigationItem.leftBarButtonItem?.customView?.aspectRatio(1)
        self.view.addSubview(navBarSeparator)
    }
    
    private func addTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
    }
    
    private func addConstraints() {
        navBarSeparator.topToSuperview()
        tableView.edgesToSuperview(excluding: [.top])
        tableView.topToBottom(of: navBarSeparator)
    }
    
    @objc func didTapExit() {
        tryGenerateSelectionChangedHaptic()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func tryGenerateSelectionChangedHaptic() {
        if UserDefaults.standard.bool(forKey: "hapticEffectOn") {
            hapticGenerator.selectionChanged()
        }
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // TODO: maintain a view model of settings item, etc
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numOfAllSections = SettingsSections.allCases.count
        let isDebugActivated = defaults.bool(forKey: "isDebugActivated")
        return isDebugActivated ? numOfAllSections : numOfAllSections - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // we put all content of every section into one big cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        switch indexPath.section {
        case 0:
            let languageRow = SettingsSelectionRowView(withTitle: "Language", selectionText: "English", didTap: { button in
                // TODO: implement localization
                self.showAlert(withTitle: "Oops", message: "Language selection is not available yet.")
            }) // populate current language
            let soundEffectRow = SettingsSwitchRowView(withTitle: "Sound effects", isOn: (defaults.value(forKey: "soundEffectOn") as? Bool) ?? true, didToggle: { toggle in
                self.defaults.set(toggle.isOn, forKey: "soundEffectOn")
            })
            let hapticsRow = SettingsSwitchRowView(withTitle: "Haptic effects", isOn: (defaults.value(forKey: "hapticEffectOn") as? Bool) ?? true, didToggle: { toggle in
                self.defaults.set(toggle.isOn, forKey: "hapticEffectOn")
            })
            cell.addRowsWithSeparators(rows: [languageRow, soundEffectRow, hapticsRow])
        case 1:
            let simulationButtonRow = SettingsSwitchRowView(withTitle: "Show simulation button", isOn: defaults.bool(forKey: "shouldShowSimulationButton"), didToggle: { toggle in
                self.defaults.set(toggle.isOn, forKey: "shouldShowSimulationButton")
            })
            let unshuffledQuestionsRow = SettingsSwitchRowView(withTitle: "Show unshuffled questions", isOn: defaults.bool(forKey: "shouldShowQuestionsUnshuffled"), didToggle: { toggle in
                self.defaults.set(toggle.isOn, forKey: "shouldShowQuestionsUnshuffled")
            })
            cell.addRowsWithSeparators(rows: [simulationButtonRow, unshuffledQuestionsRow])
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
        let title = DuolingoTitleLabel()
        title.text = SettingsSections.allCases[section].rawValue
        header.addSubview(title)
        title.topToSuperview(offset: 30)
        title.leadingToSuperview(offset: 30)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
}

class SettingsTableViewCell: UITableViewCell {
    
    private var rowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    // TODO
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let card = DuolingoBorderedCard()
        self.addSubview(card)
        card.edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
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
    }
    
}

class SettingsSwitchRowView: UIView {
    
    let label = DuolingoLabel()
    let toggle = UISwitch()
    var didToggle: ((UISwitch) -> Void)!
    
    init(withTitle title: String, isOn: Bool, didToggle: @escaping (UISwitch) -> Void) {
        super.init(frame: .zero)
        height(DuoUI.shared.SettingsRowHeight)
        toggle.isOn = isOn
        toggle.addTarget(self, action: #selector(didToggleSwitch), for: .valueChanged)
        toggle.onTintColor = UIColor(red: 151/255, green: 117/255, blue: 250/255, alpha: 1)
        addSubview(toggle)
        toggle.centerYToSuperview()
        toggle.trailingToSuperview(offset: 20)
        label.text = title
        addSubview(label)
        label.centerYToSuperview()
        label.leadingToSuperview(offset: 20)
        label.trailingToLeading(of: toggle, offset: -20)
        self.didToggle = didToggle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didToggleSwitch(sender: UISwitch) {
        didToggle(sender)
    }
    
}

class SettingsSelectionRowView: UIView {
    
    let titleLabel = DuolingoLabel()
    let selectionLabel = DuolingoLabel()
    let selectionButton = UIButton()
    var didTap: ((UIButton) -> Void)!
    
    init(withTitle title: String, selectionText: String, didTap: @escaping (UIButton) -> Void) {
        super.init(frame: .zero)
        height(DuoUI.shared.SettingsRowHeight)
        selectionButton.setImage(UIImage(systemName: "chevron.right") , for: .normal)
        addSubview(selectionButton)
        selectionButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        selectionButton.aspectRatio(1)
        selectionButton.height(20)
        selectionButton.tintColor = UIColor(white: 0.8, alpha: 1)
        selectionButton.centerYToSuperview()
        selectionButton.trailingToSuperview(offset: 20)
        selectionLabel.text = selectionText
        selectionLabel.textColor = UIColor(white: 0.8, alpha: 1)
        addSubview(selectionLabel)
        selectionLabel.centerYToSuperview()
        selectionLabel.trailingToLeading(of: selectionButton, offset: -10)
        selectionLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.text = title
        addSubview(titleLabel)
        titleLabel.centerYToSuperview()
        titleLabel.leadingToSuperview(offset: 20)
        titleLabel.trailingToLeading(of: selectionLabel, offset: -20)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.didTap = didTap
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapButton(sender: UIButton) {
        didTap(sender)
    }
    
}

extension UIViewController {
    
    func showAlert(withTitle title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
