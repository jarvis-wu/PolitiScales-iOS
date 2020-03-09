//
//  SettingsViewController.swift
//  PolitiScales
//
//  Created by Jarvis Wu on 3/8/20.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: maintain a view model of settings item, etc
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        return cell
    }
    
}

class SettingsTableViewCell: UITableViewCell {
    
    // TODO
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
