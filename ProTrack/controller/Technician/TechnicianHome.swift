//
//  TechnicianHome.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData
import MapKit
class TechnicianHome: BaseViewController,MKMapViewDelegate {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    
    var responseArray:NSArray = NSArray(array: [])
    var resultsArray:NSArray = NSArray(array: [])
    var reqID:NSString = NSString()
    
    
    
//    var firstImage:UIImage = UIImage()
//    var secondImage:UIImage = UIImage()
//    var thirdImage:UIImage = UIImage()
    
//    let tapRec1 = UITapGestureRecognizer()
//    let tapRec2 = UITapGestureRecognizer()
//    let tapRec3 = UITapGestureRecognizer()
    @IBOutlet var techdespView: UIView!
  
    @IBOutlet var techCity: UILabel!
    @IBOutlet var techStreet: UILabel!
    @IBOutlet var myTechTable: UITableView!
    @IBOutlet var techDesp: UILabel!
    @IBOutlet var techStatus: UILabel!
    
    
    @IBAction func techLogOut(sender: AnyObject){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func Accept(sender: AnyObject) {
    }
    var techName:String = String()
    var techTasks:NSArray!
    
    @IBOutlet var techPriority: UILabel!
    @IBAction func decline(sender: AnyObject) {
    }
    
//    var currentStatus:Task!
    var currentIndexPath: NSIndexPath!
    
    var lat:CLLocationDegrees = CLLocationDegrees()
    var long:CLLocationDegrees = CLLocationDegrees()
   
    var rowCount: Int = Int()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url1:NSURL = NSURL()
        
        url1 = NSURL(string: "https://TelcoApp.mybluemix.net/allTask/")!
        
        
        
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: url1)
        
        
        request.HTTPMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var responseData1 = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) as NSData?
        
        var error :NSError?
        var predicate = NSPredicate(format: "techAssigned = '\(techName)'")
        
        
        
        
        responseArray = NSJSONSerialization.JSONObjectWithData(responseData1!, options:NSJSONReadingOptions.MutableLeaves, error: &error) as NSArray
        
        resultsArray = responseArray.filteredArrayUsingPredicate(predicate!)
        
        println("\(resultsArray)")

      
        myTechTable.layer.borderColor = UIColor.blackColor().CGColor
        
        myTechTable.layer.cornerRadius = 5
        
        techdespView.layer.borderColor = UIColor.blackColor().CGColor
        techdespView.layer.cornerRadius = 3
        techdespView.layer.borderWidth = 2
        
  }
    override func viewDidAppear(animated: Bool) {
        
          self.navigationItem.setHidesBackButton(true, animated: true)
    }
  
    func getTechnicianTask(techName:NSString) {
    
  }
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1;
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return resultsArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell?
    {
        var cell1:TechCustomCell = tableView.dequeueReusableCellWithIdentifier("techCell") as TechCustomCell
        if(resultsArray.count == 0)
        {
            println("No request")
        }
        else{
        
        var reqId = (resultsArray[indexPath.row])["_id"] as NSString?
        var status = (resultsArray[indexPath.row])["status"] as NSString?

        cell1.techReqId.text = reqId
        cell1.techArea.text = (resultsArray[indexPath.row])["area"] as NSString?

        cell1.closeBtn.setTitle("X", forState: UIControlState.Normal)
        if(status == "Open")
        {
            
            cell1.closeBtn.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside )
            
        }
        else if(status == "Closed")
        {
            //cell1.closeBtn.backgroundColor = UIColor.blueColor()
            
            println("ThIs is closed Req")
            cell1.closeBtn.enabled = false
            cell1.closeBtn.setTitle("", forState: UIControlState.Normal)
            
        }
        
        
        }
        return cell1
      
    }
    
    func buttonAction(sender:AnyObject)
    {
        
        
        //Storing
       var cell1:TechCustomCell = TechCustomCell()
        if(resultsArray.count == 0)
        {
            println("No request")
        }
            
        else{
            
            println("ibib")
            //                println((resultsArray[p])["_id"])
            
            var reqId = (resultsArray[currentIndexPath.row])["_id"] as NSString
            var status = (resultsArray[currentIndexPath.row])["status"] as NSString
        
            if(status == "Open")
            {
                println(status)
              var Pstatus = "Closed"
            
//                managedObjectContext?.save(nil)
                cell1.closeBtn.enabled = false
               
                if currentIndexPath != nil {
                    
                    reqID = (resultsArray[currentIndexPath.row])["_id"] as NSString
                  
                    
                    var url:NSURL = NSURL(string: "https://TelcoApp.mybluemix.net/Stask/\(reqID)")!
                    
                    var request1 : NSMutableURLRequest = NSMutableURLRequest(URL: url)
                    
                    var keys:NSArray=NSArray(objects:"status")
                    var objects:NSArray=NSArray(objects:Pstatus)
                    
                    
                    
                    var object:NSDictionary=NSDictionary(objects: objects, forKeys: keys)
                    
                    
                    var jsonObject=NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.allZeros, error: nil)
                    var response: NSURLResponse?
                    
                    request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    request1.HTTPMethod="POST"
                    request1.HTTPBody = jsonObject
                    
                    var responseData = NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response, error: nil) as NSData?
                    myTechTable.reloadRowsAtIndexPaths(NSArray(object: currentIndexPath), withRowAnimation: UITableViewRowAnimation.Left)
                }
                else {
                    println("No current index path")
                    //This should not be executed, If executing then code problem
                   myTechTable.reloadData()
                }
                
                //                    currentTask = nil
                currentIndexPath = nil
            
            }
            }
        }
    

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        var cell1:TechCustomCell = tableView.dequeueReusableCellWithIdentifier("techCell") as TechCustomCell
        
        techdespView.hidden = false
        
        //let req = fetchedResultController2.objectAtIndexPath(indexPath) as Task
        if(resultsArray.count == 0)
        {
            println("No request")
        }
            
            
            
            
        else{
            
        
            var reqId = (resultsArray[indexPath.row])["_id"] as NSString?
            var status = (resultsArray[indexPath.row])["status"] as NSString?
            

        if(status == "Open")
        {

            currentIndexPath = indexPath

        }
            
        else
        {
            

            
            }
        
        techDesp.text = (resultsArray[indexPath.row])["desp"] as NSString?
        techCity.text = (resultsArray[indexPath.row])["city"] as NSString?
        techStreet.text = (resultsArray[indexPath.row])["street"] as NSString?
        techPriority.text = (resultsArray[indexPath.row])["priority"] as NSString?
            
        }
        }
 
    
    @IBAction func btnRouteMap(sender: AnyObject) {

        var route = self.storyboard?.instantiateViewControllerWithIdentifier("routeMap") as RouteMap
        
        route.name1 = lat
        route.name2 = long
        self.navigationController?.pushViewController(route, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
}
