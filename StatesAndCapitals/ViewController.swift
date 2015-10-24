//
//  ViewController.swift
//  StatesAndCapitals
//
//  Created by on 10/17/15.
//  Copyright © 2015 All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import QuartzCore
import AVFoundation


class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var stateMap: MKMapView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var forthButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var wrongAnswerLabel: UILabel!
    
    let speechSynthsizer = AVSpeechSynthesizer()
    let speechVoice = AVSpeechSynthesisVoiceIdentifierAlex
    //let voices = AVSpeechSynthesisVoice()
    
    var stateAbbr = [String]()
    var points = Int()
    var wrongAnswer = Int()
    let quiz = StatesAndCapitals()
    var num = Int()
    var dics = [String: [String:String]]()
    var lat = Double()
    var long = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateAbbr = quiz.quizSetup()
        initialSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: Action methods
    
    @IBAction func nextQuestion(sender: UIButton) {
        initialSetup()
        firstButton.enabled = true
        secondButton.enabled = true
        thirdButton.enabled = true
        forthButton.enabled = true
    }

    @IBAction func answer1(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
    }
    
    @IBAction func answer2(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
    }
    
    @IBAction func answer3(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
    }
    
    @IBAction func answer4(sender: UIButton) {
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
    }
    
// MARK: Helper methods
    func initialSetup() {
        if stateAbbr.isEmpty {
            let alert = UIAlertController(title: "Game over", message: "Total points: \(points)\nDo you wish to play again?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                self.stateAbbr = self.quiz.quizSetup()
                self.initialSetup()
                self.points = 0
                self.wrongAnswer = 0
                self.scoreLabel.text = "0"
                self.wrongAnswerLabel.text = "0"
            }))
            alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action) -> Void in
                //TODO pop a different view 
                
                self.firstButton.enabled = false
                self.secondButton.enabled = false
                self.thirdButton.enabled = false
                self.forthButton.enabled = false
                self.nextButton.enabled = false
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            // set question and answer labels
            num = Int(arc4random_uniform(UInt32(stateAbbr.count)))
            questionLabel.text = "What is the capital of \"\(quiz.dics[stateAbbr[num]]!["name"]!)\"?"
            secondButton.setTitle("\(quiz.dics[stateAbbr[num]]!["capital"]!)", forState: .Normal)
            thirdButton.setTitle("\(quiz.dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
            firstButton.setTitle("\(quiz.dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
            forthButton.setTitle("\(quiz.dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
            
            // capture lat and long
            lat = Double(quiz.dics[stateAbbr[num]]!["lat"]!)!
            long = Double(quiz.dics[stateAbbr[num]]!["long"]!)!
            
            // create map location based on lat, long
            let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            stateMap.setRegion(region, animated: true)
        }
        
        
        //text to speech
        let speechUtternce = AVSpeechUtterance(string: "\(questionLabel.text!)")
        speechUtternce.volume = 0.50
        if stateAbbr.isEmpty {
            speechSynthsizer.stopSpeakingAtBoundary(.Immediate)
        } else {
            speechSynthsizer.speakUtterance(speechUtternce)
        }
    }
    
    // validate answer
    func checkAnswer(title:String){
        if title == quiz.dics[stateAbbr[num]]!["capital"] {
            questionLabel.text = "Correct!!"
            
            // text to speech
            let speechUtternce = AVSpeechUtterance(string: "That is \(questionLabel.text!)")
            speechUtternce.volume = 0.50
            if stateAbbr.isEmpty {
                speechSynthsizer.stopSpeakingAtBoundary(.Immediate)
            } else {
                speechSynthsizer.speakUtterance(speechUtternce)
            }
            
            // calculate points
            ++points
            scoreLabel.text = "\(points)"
            firstButton.enabled = false
            secondButton.enabled = false
            thirdButton.enabled = false
            forthButton.enabled = false
            
        } else {
            
            questionLabel.text = "Sorry the correct answer is\n\(quiz.dics[stateAbbr[num]]!["capital"]!)"
            
            // text to speech
            let speechUtternce = AVSpeechUtterance(string: "\(questionLabel.text!)")
            speechUtternce.volume = 0.50
            if stateAbbr.isEmpty {
                speechSynthsizer.stopSpeakingAtBoundary(.Immediate)
            } else {
                speechSynthsizer.speakUtterance(speechUtternce)
            }
            
            // calculate wrong answers
            ++wrongAnswer
            wrongAnswerLabel.text = "\(wrongAnswer)"
            firstButton.enabled = false
            secondButton.enabled = false
            thirdButton.enabled = false
            forthButton.enabled = false
        }
    }
}

