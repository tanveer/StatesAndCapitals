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

//  MARK: Outlets
    
    @IBOutlet weak var stateMap: MKMapView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var forthButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var wrongAnswerLabel: UILabel!
    
// MARK: Var's and Let's
    
    let speechSynthsizer = AVSpeechSynthesizer()
    let speechVoice = AVSpeechSynthesisVoiceIdentifierAlex
    var stateAbbr = [String]()
    var points = Int()
    var wrongAnswer = Int()
    let quiz = StatesAndCapitals()
    var num = Int()
    var lat = Double()
    var long = Double()
    var name = String()
    
// MARK: Application life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateAbbr = quiz.quizSetup()
        loadGame()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
// unwind segue method
    @IBAction func cancelToViewController(segue: UIStoryboardSegue){
        stateAbbr = quiz.quizSetup()
        loadGame()
        enableButton()
        reset()
    }
    
// MARK: Answer buttons
    
    @IBAction func nextQuestion(sender: UIButton){
        //TODO
    }

    @IBAction func answer1(sender: UIButton){
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
        loadGame()
        enableButton()
    }
    
    @IBAction func answer2(sender: UIButton){
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
        loadGame()
        enableButton()
    }
    
    @IBAction func answer3(sender: UIButton){
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
        loadGame()
        enableButton()
    }
    
    @IBAction func answer4(sender: UIButton){
        let title = sender.titleLabel?.text
        checkAnswer(title!)
        stateAbbr.removeAtIndex(num)
        loadGame()
        enableButton()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VIEW" {
            let secondViewController = segue.destinationViewController as! SecondViewController
                secondViewController.points = points
                secondViewController.name = name
        }
    }
    
    // MARK: LoadGame methohd
    
    func loadGame(){
        if stateAbbr.isEmpty{
            performSegueWithIdentifier("VIEW", sender: nil)
            
        } else{
            // set question and answer labels
            num = Int(arc4random_uniform(UInt32(stateAbbr.count)))
            questionLabel.text = "What is the capital of\n\"\(quiz.dics[stateAbbr[num]]!["name"]!)\"?"
            secondButton.setTitle("\(quiz.dics[stateAbbr[num]]!["capital"]!)", forState: .Normal)
            thirdButton.setTitle("\(quiz.dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
            firstButton.setTitle("\(quiz.dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
            forthButton.setTitle("\(quiz.dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
            
            //show map
            setMap()
        }
        
        //text to speech
        let speechUtternce = AVSpeechUtterance(string: "\(questionLabel.text!)")
        textToSpeech(speechUtternce)
    }
    
    // MARK: Validate answer
    
    func checkAnswer(title:String){
        if title == quiz.dics[stateAbbr[num]]!["capital"]{
            
            // text to speech
            let speechUtternce = AVSpeechUtterance(string: "That is correct!!")
            textToSpeech(speechUtternce)
            
            // calculate points
            ++points
            scoreLabel.text = "\(points)"
            disableButton()
            
        } else{
            
            let wrong = "Sorry the correct answer is\n\(quiz.dics[stateAbbr[num]]!["capital"]!)"
            
            // text to speech
            let speechUtternce = AVSpeechUtterance(string: wrong)
            textToSpeech(speechUtternce)
            
            // calculate wrong answers
            ++wrongAnswer
            wrongAnswerLabel.text = "\(wrongAnswer)"
            disableButton()
        }
    }
    
    // MARK: Helper methods
    
    func disableButton(){
        firstButton.enabled = false
        secondButton.enabled = false
        thirdButton.enabled = false
        forthButton.enabled = false
    }
    
    func enableButton(){
        firstButton.enabled = true
        secondButton.enabled = true
        thirdButton.enabled = true
        forthButton.enabled = true
    }
    
    func reset(){
        points = 0
        wrongAnswer = 0
        scoreLabel.text = "0"
        wrongAnswerLabel.text = "0"
    }
    
    func setMap(){
        lat = Double(quiz.dics[stateAbbr[num]]!["lat"]!)!
        long = Double(quiz.dics[stateAbbr[num]]!["long"]!)!
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        stateMap.setRegion(region, animated: true)
    }
    
    func textToSpeech(text: AVSpeechUtterance){
        if stateAbbr.isEmpty {
            speechSynthsizer.stopSpeakingAtBoundary(.Immediate)
        } else {
            speechSynthsizer.speakUtterance(text)
        }
    }
}

