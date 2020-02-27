//
//  QuizViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-03.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    let questionCard = DuolingoBorderedCard()
    let questionCardIcon = UIImageView()
    let questionCardRightStack = UIStackView()
    let questionCardTitleLabel = DuolingoTitleLabel()
    let questionCardLabel = DuolingoLabel()
    let anwersContainerView = UIView()
    let goBackButton = DuolingoButton()
    let bottomView = UIView()
    let navBarSeparator = DuolingoSeparator()
    var anwersContainerViewTopConstraint: NSLayoutConstraint!
    
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
        // TODO: we do want to ask for confirmation if the user is going BACK from later questions to the first question
        // Which means we actually want to check progress, rather than current index
        if currentQuestionNumber == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Do you want to save the current session?", message: "You can choose to save your answers and come back later to finish it, or delete the progress immediately. You cannot undo this action.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Save and leave", style: .default, handler: { (_) in
                // save here
                self.navigationController?.popViewController(animated: true)
            }))
            alertController.addAction(UIAlertAction(title: "Discard and leave", style: .destructive, handler: { (_) in
                // discard here
                self.navigationController?.popViewController(animated: true)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func didTapEdit() {
        print("Edit tapped")
        // present a table view controller displaying all answered questions
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
                // TODO: add sliding in and out animations here on the question card
                let animationDistance: CGFloat = (self.view.bounds.width + self.questionCard.bounds.width)/2
                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveLinear], animations: {
                    self.questionCard.transform = CGAffineTransform(translationX: -animationDistance, y: 0)
                }) { (_) in
                    self.questionCard.alpha = 0
                    self.questionCard.transform = CGAffineTransform(translationX: animationDistance, y: 0)
                    self.questionCardLabel.text = self.shuffled[self.currentQuestionNumber].questionText
                    self.questionCardTitleLabel.text = "Question \(self.currentQuestionNumber + 1) of \(questions.count)"
                    self.questionCardIcon.image = UIImage(named: "dna")
                    self.goBackButton.setTitle(self.currentQuestionNumber == 0 ? "Go back to home page" : "Return to the previous question", for: .normal)
                    self.anwersContainerViewTopConstraint.isActive = false
                    self.anwersContainerViewTopConstraint = self.anwersContainerView.topToBottom(of: self.questionCard, offset: 20)
                    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
                        self.questionCard.alpha = 1
                        self.questionCard.transform = CGAffineTransform.identity
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
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
        self.navigationItem.leftBarButtonItem?.customView?.height(20)
        self.navigationItem.leftBarButtonItem?.customView?.aspectRatio(1)
        let editButton = UIButton()
        let editIcon = UIImage(named: "edit")?.withRenderingMode(.alwaysTemplate)
        editButton.setImage(editIcon, for: .normal)
        editButton.tintColor = .lightGray
        editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        self.navigationItem.rightBarButtonItem?.customView?.height(20)
        self.navigationItem.rightBarButtonItem?.customView?.aspectRatio(1)
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
        
        anwersContainerViewTopConstraint = anwersContainerView.topToBottom(of: questionCard, offset: 20)
        anwersContainerView.centerXToSuperview()
        anwersContainerView.leadingToSuperview(offset: 30)
        for i in 0...4 {
            let button = anwersContainerView.subviews[i]
            if i == 0 { button.bottomToTop(of: anwersContainerView, offset: 50) }
            if i == 4 { button.bottomToSuperview() }
            button.bottomToTop(of: anwersContainerView, offset: CGFloat((i + 1) * 50 + i * 12))
            button.widthToSuperview()
        }
        
        questionCard.topToBottom(of: navBarSeparator, offset: 30)
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
        navBarSeparator.topToSuperview()
    }
    
    private func addQuestionCard() {
        questionCard.addSubview(questionCardIcon)
        questionCard.addSubview(questionCardRightStack)
        questionCardRightStack.axis = .vertical
        questionCardRightStack.distribution = .equalCentering
        questionCardRightStack.spacing = 12
        questionCardRightStack.addArrangedSubview(questionCardTitleLabel)
        questionCardRightStack.addArrangedSubview(questionCardLabel)
        // TODO: Fix code priming in currentQuestionNumber didSet
        questionCardIcon.image = UIImage(named: "dna")
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

