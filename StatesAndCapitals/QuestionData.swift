//
//  QuestionData.swift
//  StatesAndCapitals
//
//  Created by Tanveer Bashir on 10/17/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import Foundation
import UIKit

struct QuestionData {
    let file = NSBundle.mainBundle().pathForResource("jsonData", ofType: "json")
    var dictionary = [String:[String:String]]()
    init(){
        self.dictionary = json()
    }
    
    func json() -> [String: [String:String]] {
        var dic = [String: [String:String]]()
        let data = NSData(contentsOfFile: file!)
        dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String: [String:String]]
        return dic
    }
    
    func createStateCapitalDictionary() -> [String: String]{
        var dic = [String:String]()
        for (_, value) in json(){
            dic.updateValue(value["capital"]!, forKey: value["name"]!)
        }
        return dic
    }
}
