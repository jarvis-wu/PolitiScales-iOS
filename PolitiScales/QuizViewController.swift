//
//  QuizViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-03.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    struct AnswerItemMetadata {
        let text: String
        let color: UIColor
        let emoji: String
    }
    
    enum AnswerItem: CaseIterable {
        case absoulutelyAgree
        case somewhatAgree
        case neutral
        case somewhatDisagree
        case absolutelyDisagree
        
        func getMetadata() -> AnswerItemMetadata {
            switch self {
            case .absoulutelyAgree:
                return AnswerItemMetadata(text: "Absoulutely agree", color: UIColor(red: 95/255, green: 162/255, blue: 250/255, alpha: 1), emoji: "💙")
            case .somewhatAgree:
                return AnswerItemMetadata(text: "Somewhat agree", color: UIColor(red: 105/255, green: 219/255, blue: 124/255, alpha: 1), emoji: "💚")
            case .neutral:
                return AnswerItemMetadata(text: "Neutral or hesitant", color: UIColor(red: 252/255, green: 196/255, blue: 25/255, alpha: 1), emoji: "💛")
            case .somewhatDisagree:
                return AnswerItemMetadata(text: "Rather disagree", color: UIColor(red: 255/255, green: 146/255, blue: 43/255, alpha: 1), emoji: "🧡")
            case .absolutelyDisagree:
                return AnswerItemMetadata(text: "Absoulutely disagree", color: UIColor(red: 255/255, green: 107/255, blue: 107/255, alpha: 1), emoji: "❤️")
            }
        }
    }
    
    // TODO: all isUserInteractionEnabled is used to let the scroll work on subviews; is this the only solution?
    
    let hapticGenerator = UISelectionFeedbackGenerator()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let progressBar = DuolingoProgressView()
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
        guard let index = anwersContainerView.subviews.firstIndex(of: sender) else { return }
        logAnswer(questionIndex: currentQuestionNumber, answerIndex: index)
        hapticGenerator.selectionChanged()
        shuffled[currentQuestionNumber].selectedIndex = index
        shuffled[currentQuestionNumber].weightedAnswer = multiplierFromIndex[index]!
        goToNext()
    }
    
    @objc func didTapGoBack() {
        hapticGenerator.selectionChanged()
        if currentQuestionNumber == 0 && numOfAnsweredQuestions == 0 { // exit
            self.navigationController?.popViewController(animated: true)
        } else if currentQuestionNumber == 0 {
            showExitConfirmationAlert()
        } else { // go back
            currentQuestionNumber -= 1
        }
    }
    
    @objc func didTapExit() {
        hapticGenerator.selectionChanged()
        // TODO: we do want to ask for confirmation if the user is going BACK from later questions to the first question
        // Which means we actually want to check progress, rather than current index
        // Solution: check the count of elements in self.shuffled for which selectedIndex != nil; if count == 0, then exit without confirmation
        if currentQuestionNumber == 0 && numOfAnsweredQuestions == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            showExitConfirmationAlert()
        }
    }
    
    @objc func didTapEdit() {
        hapticGenerator.selectionChanged()
        print("Edit tapped")
        // present a table view controller displaying all answered questions
    }
    
    // Debug only
    @objc func didTapSimulate() {
        hapticGenerator.selectionChanged()
        
        
        let alertController = UIAlertController(title: "Do you want to go directly to the end of the quiz?", message: "We will run a simulation for you.", preferredStyle: .alert)
        if self.numOfAnsweredQuestions != 0 {
            alertController.addAction(UIAlertAction(title: "Simulate unanswered questions", style: .default, handler: { (_) in
                self.getRandomAnswers(keepingExistingAnswers: true)
                // go to result
                self.calculateResult()
                self.performSegue(withIdentifier: "ResultSegue", sender: self)
            }))
        }
        alertController.addAction(UIAlertAction(title: "Simulate all questions", style: .default, handler: { (_) in
            self.getRandomAnswers(keepingExistingAnswers: false)
            // go to result
            self.calculateResult()
            self.performSegue(withIdentifier: "ResultSegue", sender: self)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func getRandomAnswers(keepingExistingAnswers: Bool) {
        for questionIndex in self.shuffled.indices {
            let isQuestionAnswered = self.shuffled[questionIndex].selectedIndex == nil
            if (keepingExistingAnswers ? isQuestionAnswered : true) {
                let answerIndex = Int.random(in: 0...4)
                logAnswer(questionIndex: questionIndex, answerIndex: answerIndex, isSimulated: true)
                self.shuffled[questionIndex].selectedIndex = answerIndex
                self.shuffled[questionIndex].weightedAnswer = self.multiplierFromIndex[answerIndex]!
            }
        }
    }
    
    private func logAnswer(questionIndex: Int, answerIndex: Int, isSimulated: Bool = false) {
        print("🤔 Question \(questionIndex + 1): \(shuffled[questionIndex].questionText)")
        print("✏️ Answer \(answerIndex + 1) is selected (\(AnswerItem.allCases[answerIndex].getMetadata().text) \(AnswerItem.allCases[answerIndex].getMetadata().emoji))\(isSimulated ? " - simulated 🎰" : "")\n")
    }
    
    private func showExitConfirmationAlert() {
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
    
    // TODO: refactor into user defaults when implementing debug mode
    let shouldShuffle = !UserDefaults.standard.bool(forKey: "shouldShowQuestionsUnshuffled")
    
    let multiplierFromIndex: [Int: Double] = [0: 1, 1: 2/3, 2: 0, 3: -2/3, 4: -1]
    var results = [String : (Int, Int)]()
    var shuffled: [Question]!
    var numOfAnsweredQuestions: Int {
        get {
            return (shuffled.filter { $0.selectedIndex != nil }).count
        }
    }
    
    // TODO: add a simulate button when implementing debug mode that jump right into result VC with random result
    var currentQuestionNumber = 0 {
        didSet {
            let progress = Float(self.numOfAnsweredQuestions) / Float(shuffled.count)
            progressBar.progress = progress
            if currentQuestionNumber != questions.count {
                let isMovingBack = currentQuestionNumber < oldValue
                let animationDistance: CGFloat = (self.view.bounds.width + self.questionCard.bounds.width) / 2 * (isMovingBack ? -1 : 1)
                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveLinear], animations: {
                    self.questionCard.transform = CGAffineTransform(translationX: -animationDistance, y: 0)
                }) { (_) in
                    self.questionCard.alpha = 0
                    self.questionCard.transform = CGAffineTransform(translationX: animationDistance, y: 0)
                    self.questionCardLabel.text = self.shuffled[self.currentQuestionNumber].questionText
                    self.questionCardTitleLabel.text = "Question \(self.currentQuestionNumber + 1) of \(questions.count)"
                    self.questionCardIcon.image = UIImage(named: self.shuffled[self.currentQuestionNumber].imageName)
                    self.goBackButton.setTitle(self.currentQuestionNumber == 0 ? "Go back to home page" : "Return to the previous question", for: .normal)
                    self.anwersContainerViewTopConstraint.isActive = false
                    self.anwersContainerViewTopConstraint = self.anwersContainerView.topToBottom(of: self.questionCard, offset: 20)
                    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
                        self.questionCard.alpha = 1
                        self.questionCard.transform = CGAffineTransform.identity
                        self.resetSelectedIndicator()
                        if let selectedIndex = self.shuffled[self.currentQuestionNumber].selectedIndex {
                            self.showSelectedAnswer(from: selectedIndex)
                        }
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
        self.shuffled = self.shouldShuffle ? questions.shuffled() : questions
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
        self.navigationItem.rightBarButtonItems = []
        if UserDefaults.standard.bool(forKey: "shouldShowSimulationButton") {
            let simulateButton = UIButton()
            let simulateIcon = UIImage(named: "shortcut")?.withRenderingMode(.alwaysTemplate)
            simulateButton.setImage(simulateIcon, for: .normal)
            simulateButton.tintColor = .lightGray
            simulateButton.addTarget(self, action: #selector(didTapSimulate), for: .touchUpInside)
            self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: simulateButton))
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
            fixedSpace.width = 15
            self.navigationItem.rightBarButtonItems?.append(fixedSpace)
        }
        self.navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: editButton))
        for item in self.navigationItem.rightBarButtonItems! {
            item.customView?.height(20)
            item.customView?.aspectRatio(1)
        }
        self.view.addSubview(navBarSeparator)
        addBottomView()
        addScrollView()
        addProgressBar()
        addQuestionCard()
        addAnswersContainerView()
        addConstraints()
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
    
    private func addConstraints() {
        goBackButton.centerXToSuperview()
        goBackButton.bottomToSuperview(offset: -25, usingSafeArea: true)
        goBackButton.leadingToSuperview(offset: 30)
        bottomView.topToBottom(of: goBackButton, offset: -75) // 50 + 25
        bottomView.widthToSuperview()
        bottomView.bottomToSuperview()
        anwersContainerViewTopConstraint = anwersContainerView.topToBottom(of: questionCard, offset: 20)
        anwersContainerView.centerXToSuperview()
        anwersContainerView.leadingToSuperview(offset: 30)
        anwersContainerView.bottom(to: contentView, offset: -30)
        for i in 0...4 {
            let button = anwersContainerView.subviews[i]
            if i == 0 { button.bottomToTop(of: anwersContainerView, offset: 50) }
            if i == 4 { button.bottomToSuperview() }
            button.bottomToTop(of: anwersContainerView, offset: CGFloat((i + 1) * 50 + i * 12))
            button.widthToSuperview()
        }
        progressBar.top(to: contentView, offset: 25)
        progressBar.centerXToSuperview()
        progressBar.leadingToSuperview(offset: 30)
        questionCard.topToBottom(of: progressBar, offset: 20)
        questionCard.centerXToSuperview()
        questionCard.leadingToSuperview(offset: 30)
        questionCard.bottom(to: questionCardLabel, offset: 20, relation: .equalOrGreater)
        questionCard.bottom(to: questionCardIcon, offset: 20, relation: .equalOrGreater)
        questionCardIcon.height(80)
        questionCardIcon.aspectRatio(1)
        questionCardIcon.leadingToSuperview(offset: 20)
        questionCardIcon.topToSuperview(offset: 20)
        questionCardRightStack.top(to: questionCardIcon)
        questionCardRightStack.trailingToSuperview(offset: 20)
        questionCardRightStack.leadingToTrailing(of: questionCardIcon, offset: 20)
        navBarSeparator.topToSuperview()
        self.view.bringSubviewToFront(bottomView)
    }
    
    private func addProgressBar() {
        self.view.addSubview(progressBar)
        progressBar.isUserInteractionEnabled = false
        // TODO: load correct progress when we implement saving session
        progressBar.setProgress(0, animated: false)
    }
    
    private func addQuestionCard() {
        questionCard.isUserInteractionEnabled = false
        questionCard.addSubview(questionCardIcon)
        questionCard.addSubview(questionCardRightStack)
        questionCardRightStack.axis = .vertical
        questionCardRightStack.distribution = .equalCentering
        questionCardRightStack.spacing = 10
        questionCardRightStack.addArrangedSubview(questionCardTitleLabel)
        questionCardRightStack.addArrangedSubview(questionCardLabel)
        // TODO: Fix code priming in currentQuestionNumber didSet
        questionCardIcon.image = UIImage(named: shuffled[0].imageName)
        questionCardTitleLabel.text = "Question \(currentQuestionNumber + 1) of \(questions.count)"
        questionCardLabel.numberOfLines = 0
        questionCardLabel.text = shuffled[0].questionText
        self.view.addSubview(questionCard)
    }
    
    private func addAnswersContainerView() {
        self.view.addSubview(anwersContainerView)
        for i in 0...4 {
            let answerItemMetadata = AnswerItem.allCases[i].getMetadata()
            let button = DuolingoButton(color: answerItemMetadata.color)
            button.setTitle(answerItemMetadata.text, for: .normal)
            button.addTarget(self, action: #selector(didSelectAnswer), for: .touchUpInside)
            anwersContainerView.addSubview(button)
        }
    }
    
    private func addBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .white
        bottomView.addSubview(goBackButton)
        goBackButton.setTitle("Go back to home page", for: .normal)
        goBackButton.addTarget(self, action: #selector(didTapGoBack), for: .touchUpInside)
        let separator = DuolingoSeparator()
        bottomView.addSubview(separator)
        separator.topToSuperview()
    }
    
    private func showSelectedAnswer(from index: Int) {
      if let button = anwersContainerView.subviews[index] as? DuolingoButton {
        button.selectedIndicator.isHidden = false
      }
    }
    
    private func resetSelectedIndicator() {
      for case let button as DuolingoButton in anwersContainerView.subviews {
        button.selectedIndicator.isHidden = true
      }
    }
    
    private func calculateResult() {
        var axes = [String : (Double, Double)](); // axis name : (value, sum)
        for question in shuffled {
            for valueYes in question.valuesYes {
                if axes[valueYes.axis] == nil {
                    axes[valueYes.axis] = (0, 0)
                }
                if question.weightedAnswer > 0 {
                    axes[valueYes.axis]?.0 += question.weightedAnswer * Double(valueYes.value)
                }
                axes[valueYes.axis]?.1 += Double(max(valueYes.value, 0))
            }
            for valueNo in question.valuesNo {
                if axes[valueNo.axis] == nil {
                    axes[valueNo.axis] = (0, 0)
                }
                if question.weightedAnswer < 0 {
                    axes[valueNo.axis]?.0 -= question.weightedAnswer * Double(valueNo.value)
                }
                axes[valueNo.axis]?.1 += Double(max(valueNo.value, 0))
            }
        }
        
        // TODO: refactor following duplicative maths into helper funcs
        
        results["c"] = (Int(((axes["c0"]!.0) / (axes["c0"]!.1) * 100).rounded()), Int(((axes["c1"]!.0) / (axes["c1"]!.1) * 100).rounded()))
        results["j"] = (Int(((axes["j0"]!.0) / (axes["j0"]!.1) * 100).rounded()), Int(((axes["j1"]!.0) / (axes["j1"]!.1) * 100).rounded()))
        results["s"] = (Int(((axes["s0"]!.0) / (axes["s0"]!.1) * 100).rounded()), Int(((axes["s1"]!.0) / (axes["s1"]!.1) * 100).rounded()))
        results["b"] = (Int(((axes["b0"]!.0) / (axes["b0"]!.1) * 100).rounded()), Int(((axes["b1"]!.0) / (axes["b1"]!.1) * 100).rounded()))
        results["p"] = (Int(((axes["p0"]!.0) / (axes["p0"]!.1) * 100).rounded()), Int(((axes["p1"]!.0) / (axes["p1"]!.1) * 100).rounded()))
        results["m"] = (Int(((axes["m0"]!.0) / (axes["m0"]!.1) * 100).rounded()), Int(((axes["m1"]!.0) / (axes["m1"]!.1) * 100).rounded()))
        results["e"] = (Int(((axes["e0"]!.0) / (axes["e0"]!.1) * 100).rounded()), Int(((axes["e1"]!.0) / (axes["e1"]!.1) * 100).rounded()))
        results["t"] = (Int(((axes["t0"]!.0) / (axes["t0"]!.1) * 100).rounded()), Int(((axes["t1"]!.0) / (axes["t1"]!.1) * 100).rounded()))
        
        results["femi"] = (Int(((axes["femi"]!.0 / axes["femi"]!.1) * 100).rounded()), 100 - Int(((axes["femi"]!.0 / axes["femi"]!.1) * 100).rounded()))
        results["reli"] = (Int(((axes["reli"]!.0 / axes["reli"]!.1) * 100).rounded()), 100 - Int(((axes["reli"]!.0 / axes["reli"]!.1) * 100).rounded()))
        results["comp"] = (Int(((axes["comp"]!.0 / axes["comp"]!.1) * 100).rounded()), 100 - Int(((axes["comp"]!.0 / axes["comp"]!.1) * 100).rounded()))
        results["prag"] = (Int(((axes["prag"]!.0 / axes["prag"]!.1) * 100).rounded()), 100 - Int(((axes["prag"]!.0 / axes["prag"]!.1) * 100).rounded()))
        results["mona"] = (Int(((axes["mona"]!.0 / axes["mona"]!.1) * 100).rounded()), 100 - Int(((axes["mona"]!.0 / axes["mona"]!.1) * 100).rounded()))
        results["vega"] = (Int(((axes["vega"]!.0 / axes["vega"]!.1) * 100).rounded()), 100 - Int(((axes["vega"]!.0 / axes["vega"]!.1) * 100).rounded()))
        results["anar"] = (Int(((axes["anar"]!.0 / axes["anar"]!.1) * 100).rounded()), 100 - Int(((axes["anar"]!.0 / axes["anar"]!.1) * 100).rounded()))
        
        // Begin logging the results
        print("\n============ Result ===========")
        
        print("\n---------- Main axes ----------\n")
        // For this section: left + neutrual + right = 100
        print("💡 Constructivism \(results["c"]!.0) : Neutrual \(100 - results["c"]!.0 - results["c"]!.1) : Essentialism \(results["c"]!.1) 🧬")
        print("\(String(repeating: "▒", count: results["c"]!.0 ))\(String(repeating: "░", count: 100 - results["c"]!.0 - results["c"]!.1))\(String(repeating: "▓", count: results["c"]!.1))\n")
        
        print("😇 Rehabilitative justice \(results["j"]!.0) : Neutrual \(100 - results["j"]!.0 - results["j"]!.1) : Punitive justice \(results["j"]!.1) 👿")
        print("\(String(repeating: "▒", count: results["j"]!.0 ))\(String(repeating: "░", count: 100 - results["j"]!.0 - results["j"]!.1))\(String(repeating: "▓", count: results["j"]!.1))\n")
        
        print("🚀 Progressism \(results["s"]!.0) : Neutrual \(100 - results["s"]!.0 - results["s"]!.1) : Conservatism \(results["s"]!.1) ✍🏼")
        print("\(String(repeating: "▒", count: results["s"]!.0))\(String(repeating: "░", count: 100 - results["s"]!.0 - results["s"]!.1))\(String(repeating: "▓", count: results["s"]!.1))\n")
        
        print("🌍 Internationalism \(results["b"]!.0) : \(100 - results["b"]!.0 - results["b"]!.1) : Nationalism \(results["b"]!.1) 🚩")
        print("\(String(repeating: "▒", count: results["b"]!.0))\(String(repeating: "░", count: 100 - results["b"]!.0 - results["b"]!.1))\(String(repeating: "▓", count: results["b"]!.1))\n")
        
        print("⚒️ Communism \(results["p"]!.0) : Neutrual \(100 - results["p"]!.0 - results["p"]!.1) : Capitalism \(results["p"]!.1) 💰")
        print("\(String(repeating: "▒", count: results["p"]!.0))\(String(repeating: "░", count: 100 - results["p"]!.0 - results["p"]!.1))\(String(repeating: "▓", count: results["p"]!.1))\n")
        
        print("📐 Regulationism \(results["m"]!.0) : Neutrual \(100 - results["m"]!.0 - results["m"]!.1) : Laissez-faire \(results["m"]!.1) 🦋")
        print("\(String(repeating: "▒", count: results["m"]!.0))\(String(repeating: "░", count: 100 - results["m"]!.0 - results["m"]!.1))\(String(repeating: "▓", count: results["m"]!.1))\n")
        
        print("🌱 Ecology \(results["e"]!.0) : Neutrual \(100 - results["e"]!.0 - results["e"]!.1) : Productivism \(results["e"]!.1) ⚙️")
        print("\(String(repeating: "▒", count: results["e"]!.0))\(String(repeating: "░", count: 100 - results["e"]!.0 - results["e"]!.1))\(String(repeating: "▓", count: results["e"]!.1))\n")
        
        print("✊🏼 Revolution \(results["t"]!.0) : Neutrual \(100 - results["t"]!.0 - results["t"]!.1) : Reformism \(results["t"]!.1) 🗳")
        print("\(String(repeating: "▒", count: results["t"]!.0))\(String(repeating: "░", count: 100 - results["t"]!.0 - results["t"]!.1))\(String(repeating: "▓", count: results["t"]!.1))\n")
        
        print("\n---------- Bonus axes ----------\n")
        // For this bonus section: yes + no = 100; if user selects anything neutral or negative, it will be 100% "no",
        // because only positive values are added to the valueYes axis, and there is no valueNo axis for any of the following.
        // i.e.: if 100%: strong characteristic; if 66%: weak characteristic; if other: no such characteristic presented
        print("👩🏻‍🦰 Feminism \(results["femi"]!.0) : Non-Feminism \(results["femi"]!.1)")
        print("\(String(repeating: "▓", count: results["femi"]!.0 ))\(String(repeating: "░", count: results["femi"]!.1))\n")
        
        print("✝️ Missionary \(results["reli"]!.0) : Non-Missionary \(results["reli"]!.1)")
        print("\(String(repeating: "▓", count: results["reli"]!.0))\(String(repeating: "░", count: results["reli"]!.1))\n")
        
        print("👁 Complotism \(results["comp"]!.0) : Non-Complotism \(results["comp"]!.1)")
        print("\(String(repeating: "▓", count: results["comp"]!.0))\(String(repeating: "░", count: results["comp"]!.1))\n")
        
        print("🛠 Pragmatism \(results["prag"]!.0) : Non-Pragmatism \(results["prag"]!.1)")
        print("\(String(repeating: "▓", count: results["prag"]!.0))\(String(repeating: "░", count: results["prag"]!.1))\n")
        
        print("👑 Monarchism \(results["mona"]!.0) : Non-Monarchism \(results["mona"]!.1)")
        print("\(String(repeating: "▓", count: results["mona"]!.0))\(String(repeating: "░", count: results["mona"]!.1))\n")
        
        print("🥬 Veganism \(results["vega"]!.0) : Non-Veganism \(results["vega"]!.1)")
        print("\(String(repeating: "▓", count: results["vega"]!.0))\(String(repeating: "░", count: results["vega"]!.1))\n")
        
        print("🏴 Anarchism \(results["anar"]!.0) : Non-Anarchism \(results["anar"]!.1)")
        print("\(String(repeating: "▓", count: results["anar"]!.0))\(String(repeating: "░", count: results["anar"]!.1))\n")
        
    }
    
    private func goToNext() {
        currentQuestionNumber += 1
    }


}

