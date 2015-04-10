
import UIKit
import CoreData

class ManagerTaskList : BaseViewController,UITableViewDelegate,UIActionSheetDelegate{
    
    
    
    @IBOutlet weak var MyView: UIView!
    
    @IBAction func MyPriorityBtn(sender: AnyObject) {
        
        
        
        actsh.tag = 0
        actsh.delegate = self
        actsh.title = "Priority List"
        for var i:Int = 0;i < 3;i++
        {
            actsh.addButtonWithTitle(priorityList[i])
            
        }
        actsh.addButtonWithTitle("Cancel")
        actsh.cancelButtonIndex = 3
        actsh.showInView(self.view)
        
        
        
    }
    @IBAction func MyTechnicianBtn(sender: AnyObject) {
        
        
        
        actsh1.tag = 1
        actsh1.delegate = self
        actsh1.title = "Technician List"
        for var i:Int = 0;i < 3;i++
        {
            actsh1.addButtonWithTitle(technicianList[i])
            
        }
        actsh1.addButtonWithTitle("Cancel")
        actsh1.cancelButtonIndex = 3
        actsh1.showInView(self.view)
    }
    
    
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var lblTechnician: UILabel!
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var MyTechnician: UILabel!
    @IBOutlet weak var MyDescription: UILabel!
    
    
    var responseArray:NSArray = NSArray(array: [])
    var resultsArray:NSArray = NSArray(array: [])
    var actsh1 = UIActionSheet()
    var actsh = UIActionSheet()
    var flag:Int = Int()
    var areaName:String = String()
    
    
    var priorityList = ["High","Medium" , "Low" ];
    var technicianList = ["Ram","Rahul","Rakesh"];
    
    var priority : String = NSString()
    var priority1 : NSString = ""
    var techAssigned : NSString = NSString()
    var techAssigned1 : NSString = NSString()
    var reqId: NSString = NSString()
    var reqID: NSString = NSString()
    
    var currentIndexPath: NSIndexPath!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        flag = 0
        self.MyView.layer.borderColor = UIColor.blackColor().CGColor
        self.MyView.layer.borderWidth = 1
        self.MyView.layer.cornerRadius = 5
        self.MyTableView.layer.borderColor = UIColor.blackColor().CGColor
        self.MyTableView.layer.borderWidth = 1
        self.MyTableView.layer.cornerRadius = 5
        
        
        MyView.becomeFirstResponder()
        var url1 = NSURL(string: "https://TelcoApp.mybluemix.net/allTask/")
        
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: url1!)
        
        request.HTTPMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var responseData1 = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) as NSData?
        
        var error :NSError?
        
        
        responseArray = NSJSONSerialization.JSONObjectWithData(responseData1!, options:NSJSONReadingOptions.MutableLeaves, error: &error) as NSArray
        
        
        var predicate = NSPredicate(format: "area = '\(areaName)'")
        
        resultsArray = responseArray.filteredArrayUsingPredicate(predicate!)
        
        println("\(resultsArray)")
        
        self.view.addSubview(MyTableView)
        self.MyTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        MyTableView.reloadData()
        
        func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
        {
            
            return 20
        }
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int { println("hello")
        return resultsArray.count;
    }
    
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        println("in the table")
        
        
        var myCell:ManagerCustomCell = tableView.dequeueReusableCellWithIdentifier("requestCell") as ManagerCustomCell
        
        if(resultsArray.count == 0)
        {
            println("No request")
        }
            
        else{
            reqId = (resultsArray[indexPath.row])["_id"] as NSString
            var a:AnyObject!
            println("\(areaName) is \(reqId)")
            myCell.reqLabel?.font = UIFont.systemFontOfSize(18.0)
            myCell.dateLabel?.font = UIFont.systemFontOfSize(13.0)
            myCell.timeLabel?.font = UIFont.systemFontOfSize(13.0)
            //
            myCell.accessoryType = UITableViewCellAccessoryType.DetailButton
            //
            //
            if (reqId != "")  {
                myCell.reqLabel?.text = (resultsArray[indexPath.row])["_id"] as NSString
                myCell.dateLabel?.text = (responseArray[indexPath.row])["date"] as NSString
                myCell.timeLabel?.text = (responseArray[indexPath.row])["time"] as NSString
            }
            
            
            a = (resultsArray[indexPath.row])["priority"]
            
            if (a == nil)
            {
                println("NO PRIORITY")
                println("Priority is Empty")
                myCell.priorityImageView?.backgroundColor = UIColor.clearColor()
                myCell.priorityImageView?.image = UIImage(named: "icon_empty_checkbox.png")
                
            }
            else
            {
                
                priority = (resultsArray[indexPath.row])["priority"] as NSString
                
                
                if(flag == 0)
                {
                    
                    if priority == "High"{
                        println("high")
                        myCell.priorityImageView?.image = nil
                        myCell.priorityImageView?.backgroundColor = UIColor.redColor()
                        
                        flag = 1
                    }
                        
                        
                    else if priority == "Medium"{
                        println("Medium")
                        myCell.priorityImageView.image = nil
                        myCell.priorityImageView.backgroundColor = UIColor.yellowColor()
                        
                        flag = 1
                        
                    }
                    else if priority == "Low"{
                        println("Low")
                        myCell.priorityImageView.image = nil
                        myCell.priorityImageView.backgroundColor = UIColor.greenColor()
                        
                        flag = 1
                    }
                }
                else if(flag == 1)
                {
                    if priority == "High"{
                        println("high")
                        myCell.priorityImageView?.image = nil
                        myCell.priorityImageView?.backgroundColor = UIColor.redColor()
                        
                        flag = 0
                    }
                        
                        
                    else if priority == "Medium"{
                        println("Medium")
                        myCell.priorityImageView.image = nil
                        myCell.priorityImageView.backgroundColor = UIColor.yellowColor()
                        flag = 0
                        
                    }
                    else if priority == "Low"{
                        println("Low")
                        myCell.priorityImageView.image = nil
                        myCell.priorityImageView.backgroundColor = UIColor.greenColor()
                        flag = 0
                    }
                }
                
            }
            
            var b:AnyObject!
            
            b = (resultsArray[indexPath.row])["techAssigned"]
            
            if (b != nil)
            {
                
                techAssigned = (resultsArray[indexPath.row])["techAssigned"] as NSString
                myCell.tLabel.hidden = false
                
            }
            else
            {
                println("NO TECHNICIAN")
                myCell.tLabel.hidden = true
            }
            
        }
        
        return myCell
        
        
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(resultsArray.count == 0)
        {
            println("No request")
        }
            
        else{
            
            reqId = (resultsArray[indexPath.row])["_id"] as NSString
            
            var reqselectedCell:ManagerCustomCell = tableView.cellForRowAtIndexPath(indexPath)! as ManagerCustomCell
            
            var ab:AnyObject!
            ab = (resultsArray[indexPath.row])["priority"]
            
            if (ab == nil)
            {
                
                if ( reqselectedCell.accessoryType == UITableViewCellAccessoryType.DetailButton) {
                    
                    currentIndexPath = indexPath
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else if(reqselectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark)
                {
                    reqselectedCell.priorityImageView.image = UIImage(named: "icon_empty_checkbox.png")
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.DetailButton
                    currentIndexPath = nil
                }
                
                
            }
            else
            {
                
                var abc:NSString = (resultsArray[indexPath.row])["priority"] as NSString
                
                
                if(reqselectedCell.accessoryType == UITableViewCellAccessoryType.Checkmark)
                {
                    
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.DetailButton
                    
                    currentIndexPath = nil
                }
                
                
            }
            var b:AnyObject!
            
            b = (resultsArray[indexPath.row])["techAssigned"]
            
            if (b == nil)
            {
                
                if ( reqselectedCell.accessoryType == UITableViewCellAccessoryType.DetailButton) {
                    
                    currentIndexPath = indexPath
                    reqselectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                
                
            }
            
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 111{
            return 50.0
        }
        
        return 44.0
        
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        
        lblTechnician.text = ""
        lblPriority.text = ""
        MyDescription.text = ""
        
        MyView.hidden = false
        
        var description : NSString = (resultsArray[indexPath.row])["desp"] as NSString
        var ab:AnyObject!
        ab = (resultsArray[indexPath.row])["priority"]
        if (ab == nil)
        {
            println("NO PRIORITY ")
            
        }
        else
        {
            
            var abc:NSString = (resultsArray[indexPath.row])["priority"] as NSString
            lblPriority.text = abc
        }
        
        var pq:AnyObject!
        pq = (resultsArray[indexPath.row])["techAssigned"]
        
        if (pq == nil)
        {
            println("NO PRIORITY ")
            
        }
        else
        {
            
            var pq:NSString = (resultsArray[indexPath.row])["techAssigned"] as NSString
            lblTechnician.text = pq
        }
        
        
        if description != ""
        {
            MyDescription.text = description
            MyDescription.numberOfLines = 0
            MyDescription.preferredMaxLayoutWidth = 70
            MyDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
            MyDescription.sizeToFit()
        }
        
        
    }
    
    
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        
        if(resultsArray.count == 0)
        {
            println("No request")
        }
        else
        {
            
            if(actionSheet.tag==0)
                
            {
                
                if (priority1 == "")
                {
                    if(buttonIndex==0)
                    {
                        priority1 = priorityList[0]
                        actionSheet.dismissWithClickedButtonIndex(1, animated: true )
                        
                    }
                    
                    if(buttonIndex==1)
                    {
                        priority1 = priorityList[1]
                    }
                    if(buttonIndex==2)
                    {
                        priority1 = priorityList[2]
                    }
                    
                    
                    
                    if currentIndexPath != nil {
                        
                        reqID = (resultsArray[currentIndexPath.row])["_id"] as NSString
                        println("Request ID" + reqID + priority)
                        
                        var url:NSURL = NSURL(string: "https://TelcoApp.mybluemix.net/Ptask/\(reqID)")!
                        
                        var request1 : NSMutableURLRequest = NSMutableURLRequest(URL: url)
                        
                        var keys:NSArray=NSArray(objects: "priority")
                        var objects:NSArray=NSArray(objects: priority1)
                        
                        
                        
                        var object:NSDictionary=NSDictionary(objects: objects, forKeys: keys)
                        
                        
                        var jsonObject=NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.allZeros, error: nil)
                        var response: NSURLResponse?
                        
                        request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        request1.HTTPMethod="POST"
                        request1.HTTPBody = jsonObject
                        
                        var responseData = NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response, error: nil) as NSData?
                        
                        self.viewDidLoad()
                        MyTableView.reloadRowsAtIndexPaths(NSArray(object: currentIndexPath), withRowAnimation: UITableViewRowAnimation.Left)
                    }
                    else {
                        
                        MyTableView.reloadData()
                    }
                    
                    currentIndexPath = nil
                    
                }
                
                
            }
                
                
                
            else if(actionSheet.tag==1)
            {
                if techAssigned1 == ""
                {
                    
                    if(buttonIndex==0)
                    {
                        techAssigned1 = technicianList[0]
                        actionSheet.dismissWithClickedButtonIndex(1, animated: true )
                    }
                    
                    if(buttonIndex==1)
                    {
                        techAssigned1 = technicianList[1]
                    }
                    if(buttonIndex==2)
                    {
                        techAssigned1 = technicianList[2]
                    }
                    
                    if currentIndexPath != nil {
                        
                        reqID = (resultsArray[currentIndexPath.row])["_id"] as NSString
                        println("Request ID" + reqID + priority1)
                        
                        var url:NSURL = NSURL(string: "https://TelcoApp.mybluemix.net/Ttask/\(reqID)")!
                        
                        var request1 : NSMutableURLRequest = NSMutableURLRequest(URL: url)
                        
                        var keys:NSArray=NSArray(objects:"techAssigned")
                        var objects:NSArray=NSArray(objects:techAssigned1)
                        
                        
                        
                        var object:NSDictionary=NSDictionary(objects: objects, forKeys: keys)
                        
                        
                        var jsonObject=NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions.allZeros, error: nil)
                        var response: NSURLResponse?
                        
                        request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        request1.HTTPMethod="POST"
                        request1.HTTPBody = jsonObject
                        
                        var responseData = NSURLConnection.sendSynchronousRequest(request1, returningResponse: &response, error: nil) as NSData?
                        
                        
                        
                        
                        MyTableView.reloadRowsAtIndexPaths(NSArray(object: self.currentIndexPath), withRowAnimation: UITableViewRowAnimation.Left)
                        
                        self.viewDidLoad()
                    }
                    else {
                        println("No current index path")
                        
                        MyTableView.reloadData()
                    }
                    
                    currentIndexPath = nil
                    
                }
                
            }
            
            
            
        }
        
        
        
    }
    
}
