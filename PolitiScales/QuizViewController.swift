//
//  QuizViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-03.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit
import SVGKit

class QuizViewController: UIViewController {
    
    let questionCard = DuolingoBorderedCard()
    let questionCardIcon = SVGKFastImageView(svgkImage: nil)!
    let questionCardRightStack = UIStackView()
    let questionCardTitleLabel = DuolingoTitleLabel()
    let questionCardLabel = DuolingoLabel()
    let anwersContainerView = UIView()
    let goBackButton = DuolingoButton()
    let bottomView = UIView()
    let navBarSeparator = DuolingoSeparator()
    
    @objc func didSelectAnswer(_ sender: UIButton) {
        if let index = anwersContainerView.subviews.firstIndex(of: sender) {
            print("\(index) is selected")
            shuffled[currentQuestionNumber].answer = multiplierFromIndex[index]!
            goToNext()
        }
    }
    
    @objc func didTapGoBack() {
        if currentQuestionNumber == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            currentQuestionNumber -= 1
        }
    }
    
    @objc func didTapExit() {
        // TODO: ask for confirmation
        self.navigationController?.popViewController(animated: true)
    }
    
    // FOR DEBUG PURPOSE; OTHERWISE IT SHOULD ALWAYS BE TRUE
    let shouldShuffle = false
    
    let multiplierFromIndex: [Int: Double] = [0: 1, 1: 2/3, 2: 0, 3: -2/3, 4: -1]
    var results = [String : (Int, Int)]()
    var shuffled: [Question] {
        get { return self.shouldShuffle ? questions.shuffled() : questions }
        set {}
    }
    
    var currentQuestionNumber = 0 {
        didSet {
            if currentQuestionNumber != questions.count {
                questionCardLabel.text = shuffled[currentQuestionNumber].questionText
                questionCardTitleLabel.text = "Question \(currentQuestionNumber + 1) of \(questions.count)"
                let urlPath = Bundle.main.url(forResource: "dna", withExtension: "svg")
                questionCardIcon.image = SVGKImage(contentsOf: urlPath)
                goBackButton.setTitle(currentQuestionNumber == 0 ? "Go back to home page" : "Return to the previous question", for: .normal)
            } else {
                calculateResult()
                performSegue(withIdentifier: "ResultSegue", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "PolitiScale"
        let exitButton = UIButton()
        let exitIcon = UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate)
        exitButton.setImage(exitIcon, for: .normal)
        exitButton.tintColor = .lightGray
        exitButton.addTarget(self, action: #selector(didTapExit), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: exitButton)
        self.navigationItem.leftBarButtonItem?.customView?.width(18)
        self.navigationItem.leftBarButtonItem?.customView?.aspectRatio(1)
        self.view.addSubview(navBarSeparator)
        addQuestionCard()
        addAnswersContainerView()
        addBottomView()
        addConstraints()
    }
    
    private func addConstraints() {
        goBackButton.centerXToSuperview()
        goBackButton.bottomToSuperview(offset: -30, usingSafeArea: true)
        goBackButton.leadingToSuperview(offset: 30)
        bottomView.topToBottom(of: goBackButton, offset: -80)
        bottomView.widthToSuperview()
        bottomView.bottomToSuperview()
        
        anwersContainerView.bottomToTop(of: bottomView, offset: -50)
//        anwersContainerView.centerYToSuperview()
        anwersContainerView.centerXToSuperview()
        anwersContainerView.leadingToSuperview(offset: 30)
        for i in 0...4 {
            let button = anwersContainerView.subviews[i]
            if i == 0 { button.bottomToTop(of: anwersContainerView, offset: 50) }
            if i == 4 { button.bottomToSuperview() }
            button.bottomToTop(of: anwersContainerView, offset: CGFloat((i + 1) * 50 + i * 12))
            button.widthToSuperview()
        }
        
        questionCard.topToSuperview(offset: 50)
        questionCard.centerXToSuperview()
        questionCard.leadingToSuperview(offset: 30)
        questionCard.bottom(to: questionCardLabel, offset: 30)
        questionCardIcon.height(80)
        questionCardIcon.aspectRatio(1)
        questionCardIcon.leadingToSuperview(offset: 20)
        questionCardIcon.topToSuperview(offset: 20)
        questionCardRightStack.top(to: questionCardIcon)
        questionCardRightStack.trailingToSuperview(offset: 20)
        questionCardRightStack.leadingToTrailing(of: questionCardIcon, offset: 20)
        navBarSeparator.topToSuperview(offset: 5)
    }
    
    private func addQuestionCard() {
        questionCard.addSubview(questionCardIcon)
        questionCard.addSubview(questionCardRightStack)
        questionCardRightStack.axis = .vertical
        questionCardRightStack.distribution = .equalCentering
        questionCardRightStack.spacing = 12
        questionCardRightStack.addArrangedSubview(questionCardTitleLabel)
        questionCardRightStack.addArrangedSubview(questionCardLabel)
        // TODO: Fix priming in currentQuestionNumber didSet
        let urlPath = Bundle.main.url(forResource: "dna", withExtension: "svg")
        questionCardIcon.image = SVGKImage(contentsOf: urlPath)
        questionCardTitleLabel.text = "Question \(currentQuestionNumber + 1) of \(questions.count)"
        questionCardLabel.numberOfLines = 0
        questionCardLabel.text = shuffled[0].questionText
        self.view.addSubview(questionCard)
    }
    
    private func addAnswersContainerView() {
        self.view.addSubview(anwersContainerView)
        let titles = ["Absoulutely agree", "Somewhat agree", "Neutral or hesitant", "Rather disagree", "Absoulutely disagree"]
        let colors: [UIColor] = [.systemBlue, .systemGreen, .systemYellow, .systemOrange, .systemRed]
        for i in 0...4 {
            let button = DuolingoButton()
            button.mainColor = colors[i]
            button.setTitle(titles[i], for: .normal)
            button.addTarget(self, action: #selector(didSelectAnswer), for: .touchUpInside)
            anwersContainerView.addSubview(button)
        }
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.addSubview(goBackButton)
        goBackButton.setTitle("Go back to home page", for: .normal)
        goBackButton.addTarget(self, action: #selector(didTapGoBack), for: .touchUpInside)
        let separator = DuolingoSeparator()
        bottomView.addSubview(separator)
        separator.topToSuperview()
    }
    
    func calculateResult() {
        var axes = [String : (Double, Double)](); // axis name : (value, sum)
        for question in shuffled {
            for valueYes in question.valuesYes {
                if axes[valueYes.axis] == nil {
                    axes[valueYes.axis] = (0, 0)
                }
                if question.answer > 0 {
                    axes[valueYes.axis]?.0 += question.answer * Double(valueYes.value)
                }
                axes[valueYes.axis]?.1 += Double(max(valueYes.value, 0))
            }
            for valueNo in question.valuesNo {
                if axes[valueNo.axis] == nil {
                    axes[valueNo.axis] = (0, 0)
                }
                if question.answer < 0 {
                    axes[valueNo.axis]?.0 -= question.answer * Double(valueNo.value)
                }
                axes[valueNo.axis]?.1 += Double(max(valueNo.value, 0))
            }
        }
        
        results["c"] = (Int(((axes["c0"]!.0) / (axes["c0"]!.1) * 100).rounded()), Int(((axes["c1"]!.0) / (axes["c1"]!.1) * 100).rounded()))
        results["j"] = (Int(((axes["j0"]!.0) / (axes["j0"]!.1) * 100).rounded()), Int(((axes["j1"]!.0) / (axes["j1"]!.1) * 100).rounded()))
        results["s"] = (Int(((axes["s0"]!.0) / (axes["s0"]!.1) * 100).rounded()), Int(((axes["s1"]!.0) / (axes["s1"]!.1) * 100).rounded()))
        results["b"] = (Int(((axes["b0"]!.0) / (axes["b0"]!.1) * 100).rounded()), Int(((axes["b1"]!.0) / (axes["b1"]!.1) * 100).rounded()))
        results["p"] = (Int(((axes["p0"]!.0) / (axes["p0"]!.1) * 100).rounded()), Int(((axes["p1"]!.0) / (axes["p1"]!.1) * 100).rounded()))
        results["m"] = (Int(((axes["m0"]!.0) / (axes["m0"]!.1) * 100).rounded()), Int(((axes["m1"]!.0) / (axes["m1"]!.1) * 100).rounded()))
        results["e"] = (Int(((axes["e0"]!.0) / (axes["e0"]!.1) * 100).rounded()), Int(((axes["e1"]!.0) / (axes["e1"]!.1) * 100).rounded()))
        results["t"] = (Int(((axes["t0"]!.0) / (axes["t0"]!.1) * 100).rounded()), Int(((axes["t1"]!.0) / (axes["t1"]!.1) * 100).rounded()))
        
        print("Constructivism \(results["c"]!.0) : Neutrual \(100 - results["c"]!.0 - results["c"]!.1) : Essentialism \(results["c"]!.1)")
        print("Rehabilitative justice \(results["j"]!.0) : Neutrual \(100 - results["j"]!.0 - results["j"]!.1) : Punitive justice \(results["j"]!.1)")
        print("Progressism \(results["s"]!.0) : Neutrual \(100 - results["s"]!.0 - results["s"]!.1) : Conservatism \(results["s"]!.1)")
        print("Internationalism \(results["b"]!.0) : \(100 - results["b"]!.0 - results["b"]!.1) : Nationalism \(results["b"]!.1)")
        print("Communism \(results["p"]!.0) : Neutrual \(100 - results["p"]!.0 - results["p"]!.1) : Capitalism \(results["p"]!.1)")
        print("Regulationism \(results["m"]!.0) : Neutrual \(100 - results["m"]!.0 - results["m"]!.1) : Laissez-faire \(results["m"]!.1)")
        print("Ecology \(results["e"]!.0) : Neutrual \(100 - results["e"]!.0 - results["e"]!.1) : Productivism \(results["e"]!.1)")
        print("Revolution \(results["t"]!.0) : Neutrual \(100 - results["t"]!.0 - results["t"]!.1) : Reformism \(results["t"]!.1)")
        
    }
    
    func goToNext() {
        currentQuestionNumber += 1
    }


}

