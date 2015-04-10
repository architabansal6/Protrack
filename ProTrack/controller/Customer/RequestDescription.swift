//
//  RequestDescription.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class RequestDescription: UIViewController {
    var str:String = String()
    var firstImage:UIImage = UIImage()
    var secondImage:UIImage = UIImage()
    var thirdImage:UIImage = UIImage()
    
    let tapRec1 = UITapGestureRecognizer()
    let tapRec2 = UITapGestureRecognizer()
    let tapRec3 = UITapGestureRecognizer()
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblReq: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.myView.layer.borderColor = UIColor.blackColor().CGColor
        self.myView.layer.borderWidth = 2
        self.myView.layer.cornerRadius = 6
        
        self.title = "Request Description"
        
        lblReq.text = str
        
        var url1:NSURL = NSURL(string: "https://TelcoApp.mybluemix.net/allTask/")!
        println(str)
        var request1:NSMutableURLRequest=NSMutableURLRequest(URL: url1)
        
        request1.HTTPMethod="GET"
        request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request1.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var responseData1 = NSURLConnection.sendSynchronousRequest(request1, returningResponse: nil, error: nil) as NSData?
        
        var error :NSError?
        
        var responseArray = NSJSONSerialization.JSONObjectWithData(responseData1!, options:NSJSONReadingOptions.MutableLeaves, error: &error) as? NSArray
        
        
        if(responseArray?.count == nil)
        {
            println("No request")
        }
        else{
            
            
            for res in responseArray!
            {
                
                
               
                 var reqId = res["_id"] as NSString
                if(reqId == str)
                {
                lblReq.text = reqId
                var desp = res["desp"] as NSString
                lblDescription.text =  desp
                println("description \(desp)")
                var date = res["date"] as NSString
                 lblDate.text = date
                var time = res["time"] as NSString
                 lblTime.text = time
                    
                lblStreet.text = res["street"] as NSString
                lblArea.text = res["area"] as NSString
                lblCity.text = res["city"] as NSString
                lblStatus.text = res["status"] as NSString

                
            }
        }
        
        
   
    
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}

