//
//  StatesAndCapitals.swift
//  StatesAndCapitals
//
//  Created by Tanveer Bashir on 10/23/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit

class StatesAndCapitals: NSObject {
    
    var dics = [String: [String:String]]()
    var lat = Double()
    var long = Double()
    var quizData = QuestionData()
    
    
    func quizSetup() -> [String] {
        var stateAbbr = [String]()
        // states abbriviation array
        for (key, _) in quizDataDictionary(){
            stateAbbr.append(key)
        }
        return stateAbbr
    }
    
    func quizDataDictionary() -> [String:[String:String]]{
        return quizData.json()
    }
}
