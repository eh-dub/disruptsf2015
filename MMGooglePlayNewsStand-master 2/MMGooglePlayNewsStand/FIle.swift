//
//  FIle.swift
//  MMGooglePlayNewsStand
//
//  Created by Daniel Bessonov on 9/20/15.
//  Copyright (c) 2015 madapps. All rights reserved.
//

import Foundation
import Foundation
import UIKit

var dataHelper = DataHelper()

struct DataHelper {
    func initializeView(keyText: String, vc: MMSampleTableViewController){
        SwiftSpinner.show("Loading...", animated: true)
        request(.GET, "http://104.236.159.247:8181/top", parameters: ["term": keyText]).responseJSON {
            (request, response, json, error) in
            
            
            
            var json = JSON(json!);
            let count = json.arrayValue.count
            for i in 0..<count
            {
                var subjson = json.arrayValue[i]
                
                var title = subjson["title"].stringValue
                var entitieValues: [String] = subjson["entities"].arrayValue.map{ $0.stringValue}
                var first3Entities = Array(entitieValues[0..<count - 1])
                entities.append(first3Entities)
                
                //var id: String = subjson["id"].stringValue
                
                titleToPass.append(title)
                //idToPass.append(id)
            }
            //title1 = self.textField.text
            title_1 = keyText
            SwiftSpinner.hide()
            vc.tableView.reloadData()
            
        }
        
    }
    
}