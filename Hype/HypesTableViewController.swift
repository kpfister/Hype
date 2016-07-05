//
//  HypesTableViewController.swift
//  Hype
//
//  Created by Karl Pfister on 7/1/16.
//  Copyright © 2016 Karl Pfister. All rights reserved.
//

import UIKit
import CloudKit

class HypesTableViewController: UITableViewController, UITextFieldDelegate {
    
    var hypes = [CKRecord]()
    var refresh:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to see new Hype")
        refresh.addTarget(self, action: #selector(HypesTableViewController.loadData), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refresh)
        
        let logo = UIImage(named: "HypeTitle")?.stretchableImageWithLeftCapWidth(0, topCapHeight: 0)
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.setBackgroundImage(logo, forBarMetrics: .Default)
//        let barPosition = UIBarPosition(rawValue: 200)
//        self.navigationController?.navigationBar.setBackgroundImage(logo, forBarPosition: barPosition!, barMetrics: .Default)

        
        loadData()
        
    }
    
    
    // mc
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
    
    // mc
    @IBAction func addHype(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Get Hype", message: "What is hype may never die", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            textField.placeholder = "Hype has a limit of 45 characters."
            textField.autocorrectionType = .Yes
            textField.autocapitalizationType = .Sentences
            textField.delegate = self
    
            

        }
        
        alertController.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alertController.textFields!.first!

            if textField.text != "" {
                
                let newHype = CKRecord(recordType: "Hype")
                newHype["content"] = textField.text
                
                let publicData = CKContainer.defaultContainer().publicCloudDatabase
                publicData.saveRecord(newHype, completionHandler: { (record: CKRecord?, error: NSError?) -> Void in
                    if error == nil {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.tableView.beginUpdates()
                            self.hypes.insert(newHype, atIndex: 0)
                            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
                            self.tableView.endUpdates()
                        })
                        
                        
                    } else{
                        print("Error saving")
                    }
                })
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > textField.text?.characters.count {
            return false
        }
        let newLength = (textField.text?.characters.count)! + string.characters.count - range.length
        return newLength <= 45
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hypes.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hypeCell", forIndexPath: indexPath)
        
        if hypes.count == 0 {
            return cell
        }
        
        
        // model
        let hype = hypes[indexPath.row]
        if let hypeContent = hype["content"] as? String {
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "MM/dd/yyyy"
            _ = dateFormat.stringFromDate(hype.creationDate!)
            
            cell.textLabel?.text = hypeContent
            cell.detailTextLabel?.text = hype.creationDate?.stringValue()
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
