//
//  ViewController.swift
//  StatesAndCapitals
//
//  Created by on 10/17/15.
//  Copyright © 2015 All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var forthButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: NSLayoutConstraint!
    var score = Int()
    let json = QuestionData()
    var dictionary = [String : String]()
    var num = Int()
    var states = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionary = json.createStateCapitalDictionary()
        setQ()
        
    }
    
// MARK: Action methods
    
    @IBAction func nextQuestion(sender: UIButton) {
        setQ()
    }

    @IBAction func answer1(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
    }
    
    @IBAction func answer2(sender: UIButton) {
        let title = sender.titleLabel?.text
       checkAnswer(title!)
    }
    
    @IBAction func answer3(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
    }
    
    @IBAction func answer4(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
    }
    
// MARK: Helper methods
    func setQ(){
        for (key, _) in dictionary {
            states.append(key)
        }
        num = Int(arc4random_uniform(UInt32(states.count)))
        let state = states[num]
        questionLabel.text = "What is the capital of \"\(state)\"?"
        secondButton.setTitle("\(dictionary[states[num]]!)", forState: .Normal)
        thirdButton.setTitle("\(dictionary[states[10]]!)", forState: .Normal)
        firstButton.setTitle("\(dictionary[states[15]]!)", forState: .Normal)
        forthButton.setTitle("\(dictionary[states[22]]!)", forState: .Normal)
    }
    
    func checkAnswer(title:String){
        if title == dictionary[states[num]] {
            questionLabel.text = "Correct!!"
        }
        else {
            questionLabel.text = "Sorry the correct answer is\n\(dictionary[states[num]]!)"
        }
    }
}

