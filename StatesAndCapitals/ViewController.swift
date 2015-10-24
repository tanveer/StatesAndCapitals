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

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var stateMap: MKMapView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var forthButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    var stateAbbr = [String]()
    var score = Int()
    var json = StatesAndCapitals()
    var num = Int()
    var dics = [String: [String:String]]()
    var lat = Double()
    var long = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        dics = json.quizDataDictionary()
        stateAbbr = json.quizSetup()
        // random number
        num = Int(arc4random_uniform(UInt32(stateAbbr.count)))
        
        // set question label and answer buttons
        questionLabel.text = "What is the capital of \"\(dics[stateAbbr[num]]!["name"]!)\"?"
        secondButton.setTitle("\(dics[stateAbbr[num]]!["capital"]!)", forState: .Normal)
        thirdButton.setTitle("\(dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
        firstButton.setTitle("\(dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
        forthButton.setTitle("\(dics[stateAbbr[Int(arc4random_uniform(UInt32(stateAbbr.count)))]]!["capital"]!)", forState: .Normal)
        
        // capture lat and long 
        lat = Double(dics[stateAbbr[num]]!["lat"]!)!
        long = Double(dics[stateAbbr[num]]!["long"]!)!
        
        // create map location based on lat, long
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        stateMap.setRegion(region, animated: true)
    }
    
    // validate answer
    func checkAnswer(title:String){
        if title == dics[stateAbbr[num]]!["capital"] {
            questionLabel.text = "Correct!!"
            ++score
            scoreLabel.text = "\(score)"
            firstButton.enabled = false
        } else {
            questionLabel.text = "Sorry the correct answer is\n\(dics[stateAbbr[num]]!["capital"]!)"
            --score
            scoreLabel.text = "\(score)"
        }
    }
}

