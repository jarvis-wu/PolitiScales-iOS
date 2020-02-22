//
//  QuizViewController.swift
//  PolitiScales
//
//  Created by Jarvis Zhaowei Wu on 2020-01-03.
//  Copyright © 2020 jarviswu. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var goBackButton: UIButton!
    
    @IBAction func didSelectAnswer(_ sender: UIButton) {
        guard let stack = sender.superview as? UIStackView else { return }
        if let index = stack.arrangedSubviews.firstIndex(of: sender) {
            print("\(index) is selected")
            shuffled[currentQuestionNumber].answer = multiplierFromIndex[index]!
        }
        goToNext()
    }
    
    @IBAction func didSelectGoBack(_ sender: UIButton) {
        if currentQuestionNumber == 0 {
            self.navigationController?.popViewController(animated: true)
        } else {
            currentQuestionNumber -= 1
        }
    }
    
    let multiplierFromIndex: [Int: Double] = [0: 1, 1: 2/3, 2: 0, 3: -2/3, 4: -1]
    
    var results = [String : (Int, Int)]()
    
    var shuffled = questions.shuffled()
    
    var currentQuestionNumber = 0 {
        didSet {
            if currentQuestionNumber != questions.count {
                questionNumberLabel.text = "Question \(currentQuestionNumber + 1) of \(questions.count)"
                questionTextLabel.text = shuffled[currentQuestionNumber].questionText
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
        questionNumberLabel.text = "Question \(currentQuestionNumber + 1) of \(questions.count)"
        questionTextLabel.text = shuffled[0].questionText
        for button in answersStackView.arrangedSubviews {
            button.layer.cornerRadius = 8
        }
        goBackButton.layer.cornerRadius = 8
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

