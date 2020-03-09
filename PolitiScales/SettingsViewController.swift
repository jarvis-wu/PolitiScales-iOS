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
         - "isShowingRandomResultAvailable"
         - "isShufflingQuestions"
    */
    
    enum SettingsSections: String, CaseIterable {
        case general = "General"
        case debug = "Debug"
    }

    var ui = DuoUI.shared
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
        self.view.addSubview(tableView)
    }
    
    private func addConstraints() {
        navBarSeparator.topToSuperview()
        tableView.edgesToSuperview(excluding: [.top])
        tableView.topToBottom(of: navBarSeparator)
    }
    
    @objc func didTapExit() {
        hapticGenerator.selectionChanged()
        self.navigationController?.popViewController(animated: true)
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // TODO: maintain a view model of settings item, etc
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numOfAllSections = SettingsSections.allCases.count
        let isDebugActivated = UserDefaults.standard.bool(forKey: "isDebugActivated")
        return isDebugActivated ? numOfAllSections : numOfAllSections - 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // we put all content of every section into one big cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
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
    
    // TODO
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let card = DuolingoBorderedCard()
        self.addSubview(card)
        card.height(200)
        card.edgesToSuperview(insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
