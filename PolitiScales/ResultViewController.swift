//
//  ResultViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-05.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func didSelectRestart(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        restartButton.layer.cornerRadius = 8
    }
    
}
