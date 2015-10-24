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
    var quizData = QuestionData()
    
    override init() {
        super.init()
        self.dics = quizData.dictionary
    }
    
    func quizSetup() -> [String] {
        // states abbriviation array
        var stateAbbr = [String]()
        for (key, _) in quizData.dictionary {
            stateAbbr.append(key)
        }
        return stateAbbr
    }
    
}
