//
//  RequestLog.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class RequestLog: BaseViewController
{
    var responseArray:NSArray = NSArray(array: [])
    @IBAction func btnLogout(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var myTableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    var rowCount: Int = Int()
    var p = 0
    
    func taskFetchRequest()->NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        let sortDescriptor = NSSortDescriptor(key:"date", ascending:false)
        let st = NSSortDescriptor(key:"time", ascending:false)
        fetchRequest.sortDescriptors=[sortDescriptor,st]
        return fetchRequest
        
    }
    
    func getFetchedResultController()->NSFetchedResultsController
    {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
        
    }
    
    
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.myTableView.layer.borderColor = UIColor.blackColor().CGColor
        self.myTableView.layer.borderWidth = 2
        self.myTableView.layer.cornerRadius = 5
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Request Log"
        
        var url1:NSURL = NSURL(string: "https://TelcoApp.mybluemix.net/allTask/")!
        
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: url1)
        
        
        request.HTTPMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var responseData1 = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) as NSData?
        
        var error :NSError?
        
        
        
         responseArray = NSJSONSerialization.JSONObjectWithData(responseData1!, options:NSJSONReadingOptions.MutableLeaves, error: &error) as NSArray!
        
        

        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = "Back"
        
        
        
    }
    
    //MARK: UITableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {        return responseArray.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell?
    {
         var cell:CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        
        println("cell for row")

        
              if(responseArray.count == 0)
        {
            println("No request")
        }
            
            
            
            
        else{
            
          
            
            cell.reqId.text = (responseArray[indexPath.row])["_id"] as NSString
            cell.lblDate.text = (responseArray[indexPath.row])["date"] as NSString
            cell.lblTime.text = (responseArray[indexPath.row])["time"] as NSString
            cell.status.text = (responseArray[indexPath.row])["status"] as NSString

       }
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var viewC: RequestDescription = self.storyboard?.instantiateViewControllerWithIdentifier("segue") as RequestDescription

        self.navigationController?.pushViewController(viewC, animated: true)
        
        viewC.str = (responseArray[indexPath.row])["_id"] as NSString
        
        println("did selectrow")

        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier=="segue"
        {
            let cell = sender as UITableViewCell
            let indexPath = myTableView.indexPathForCell(cell)
            let despCtrl:RequestDescription = segue.destinationViewController as RequestDescription
            let task:Task = fetchedResultController.objectAtIndexPath(indexPath!) as Task
            despCtrl.str = (responseArray[indexPath!.row])["_id"] as NSString
        }

    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
}
