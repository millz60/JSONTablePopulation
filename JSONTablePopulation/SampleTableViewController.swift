//
//  SampleTableViewController.swift
//  JSONTablePopulation
//
//  Created by Matt Milner on 7/25/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit

class SampleTableViewController: UITableViewController {
    
    var sampleItems = [SampleItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        populateTableView()
        
        
        
        
        
    }
    
    private func populateTableView(){
        
        // String
        let tableCellDataSourceAPI = "http://jsonplaceholder.typicode.com/photos"
        
        //
        guard let dataSourceURL = NSURL(string: tableCellDataSourceAPI) else {
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue) {
        
            session.dataTaskWithURL(dataSourceURL){ (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
                guard let jsonResult = NSString(data: data!, encoding: NSUTF8StringEncoding) else {
                    fatalError("Error formatting data")
                }
            
                let jsonSampleArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
            
                print(jsonSampleArray)
            
                for item in jsonSampleArray {
                
                    let sampleItem = SampleItem()
                    sampleItem.title = item.valueForKey("title") as! String
                    sampleItem.thumbnailUrl = item.valueForKey("thumbnailUrl") as! String
                
                    self.sampleItems.append(sampleItem)
                
                }
            
            
                dispatch_async(dispatch_get_main_queue(), {
                
                    self.tableView.reloadData()
                
                
                })
            }.resume()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sampleItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell", forIndexPath: indexPath)

        // Configure the cell...
        
        let sampleItem = self.sampleItems[indexPath.row]
        
        guard let imageURL = NSURL(string: sampleItem.thumbnailUrl) else {
            fatalError("Invalid URL")
        }
        
        let imageData = NSData(contentsOfURL: imageURL)
        
        let image = UIImage(data: imageData!)
        
        cell.imageView?.image = image
        
        cell.textLabel?.text = sampleItem.title

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
