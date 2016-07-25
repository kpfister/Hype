//
//  HypeController.swift
//  Hype
//
//  Created by Karl Pfister on 7/6/16.
//  Copyright © 2016 Karl Pfister. All rights reserved.
//

import Foundation
import CloudKit

var hypes = [CKRecord]()

var sharedInstance = HypeController()

class HypeController {
    
    func loadData () {
        hypes = [CKRecord]()
        
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        
        let query = CKQuery(recordType: "Hype", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false) ]
        publicData.performQuery(query, inZoneWithID: nil, completionHandler: { (results:[CKRecord]?, error: NSError?) in
            if let hypes = results {
                self.hypes = hypes
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                })
            }
        })
        
    }

}

// mc

