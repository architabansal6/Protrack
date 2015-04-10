//
//  ManagerHome.swift
//  ProTrack
//
//  Created by Sunny on 25/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ManagerHome: BaseViewController, MKMapViewDelegate
{
    var highCount:Int = Int()
    var mediumCount:Int = Int()
    var lowCount:Int = Int()
    var taskUnAssigned:Int = Int()
    var arrayArea = []
   
    @IBOutlet var MyMapView: MKMapView!
    @IBOutlet var MapLabel: UILabel!
    
    var cust:CustomCircle = CustomCircle()
    
    var count1:Int = Int()
    var count2:Int = Int()
    var count3:Int = Int()
  

    
    var resultsNagwara:NSArray = NSArray(array: [])
    var resultsBTM:NSArray = NSArray(array: [])
    var resultsKormangla:NSArray = NSArray(array: [])
    var resultsBanerghatta:NSArray = NSArray(array: [])
   
    
    var areaList = ["Nagwara","BTM","Kormangla","Banerghatta"]
    //
    //     var responseArray:NSArray = NSArray(array: [])
    
    var  annotation = CustomAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.setHidesBackButton(true, animated: true)
        MyMapView.delegate = self;

        //MAP VIEW
        
   
               var url1 = NSURL(string: "https://TelcoApp.mybluemix.net/allTask/")
        
        var request:NSMutableURLRequest=NSMutableURLRequest(URL: url1!)
        
        
        request.HTTPMethod="GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        
        
        var responseData1 = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) as NSData!
        
        var error :NSError?
        
        var  responseArray = NSJSONSerialization.JSONObjectWithData(responseData1, options:NSJSONReadingOptions.MutableLeaves, error: &error) as NSArray
        
        var predicate1 = NSPredicate(format: "area = %@","Nagwara")
        
        resultsNagwara = responseArray.filteredArrayUsingPredicate(predicate1!)
        
        var predicate2 = NSPredicate(format: "area = %@","BTM")
        
        resultsBTM = responseArray.filteredArrayUsingPredicate(predicate2!)
        
        var predicate3 = NSPredicate(format: "area = %@","Kormangla")
        
        resultsKormangla = responseArray.filteredArrayUsingPredicate(predicate3!)

        var predicate4 = NSPredicate(format: "area = %@","Banerghatta")
        
        resultsBanerghatta = responseArray.filteredArrayUsingPredicate(predicate4!)
        if (resultsNagwara.count == 0 )
        {
            
            println("no address")
        }
            
        else
        {
            lowCount = 0
            highCount = 0
            mediumCount = 0
            taskUnAssigned = 0
        println("In nagwara")
       for l in resultsNagwara
       {
            var currentpriority: NSString

               var a:AnyObject!
                    a = l["priority"]
                   
                    if a == nil
                    {
                        println("Nil priority")
                    }
                    else
                    {
                        currentpriority = l["priority"] as String
                        if currentpriority == "High"
                        {
                            
                            highCount++
                        }
                        
                        if currentpriority == "Medium"
                        {
                            mediumCount++
                        }
                        
                        
                        if currentpriority == "Low"
                        {
                            lowCount++
                        }
                        
                    }
        
        }
            
            taskUnAssigned = resultsNagwara.count - (highCount + mediumCount + lowCount)
            
            for l in resultsNagwara
            {
                
                print("IN annotation")
            var lati:CLLocationDegrees = l["latitude"] as CLLocationDegrees!
                    var longi:CLLocationDegrees = l["longitude"] as CLLocationDegrees!
                    println("my \(lati)")
                    println(longi)
                    
                    var location = CLLocationCoordinate2DMake(lati, longi)
                    
                    let span = MKCoordinateSpanMake(0.15, 0.15)
                    var region = MKCoordinateRegion(center: location, span: span)
                    
                    MyMapView.setRegion(region, animated: true)
                    annotation.setCoordinate(location)
                    annotation.title = l["area"] as NSString
                
                annotation.subtitle = "India"
                
                annotation.title1 = [String(highCount),String(lowCount),String(mediumCount),String(taskUnAssigned)]
                
                
                MyMapView.addAnnotation(annotation)
                annotation = CustomAnnotation()


            }
              
        }
        
        
        //BTM
        
        if (resultsBTM.count == 0 )
        {
            
            println("no address")
        }
            
        else
        {
            
            lowCount = 0
            highCount = 0
            mediumCount = 0
            taskUnAssigned = 0

           
            for l in resultsBTM
            {
                
              
                var currentpriority: NSString
                
                var a:AnyObject!
                a = l["priority"]
                
                if a == nil
                {
                    println("Nil priority")
                }
                else
                {
                    currentpriority = l["priority"] as String
                    if currentpriority == "High"
                    {
                        
                        highCount++
                    }
                    
                    if currentpriority == "Medium"
                    {
                        mediumCount++
                    }
                    
                    
                    if currentpriority == "Low"
                    {
                        lowCount++
                    }
                    
                }
                
            }
            
            taskUnAssigned = resultsBTM.count - (highCount + mediumCount + lowCount)
            
            for l in resultsBTM
            {
                
                print("IN annotation")
                var lati:CLLocationDegrees = l["latitude"] as CLLocationDegrees!
                var longi:CLLocationDegrees = l["longitude"] as CLLocationDegrees!
                println("my \(lati)")
                println(longi)
                
                var location = CLLocationCoordinate2DMake(lati, longi)
                
                let span = MKCoordinateSpanMake(0.15, 0.15)
                var region = MKCoordinateRegion(center: location, span: span)
                
                MyMapView.setRegion(region, animated: true)
                annotation.setCoordinate(location)
                annotation.title = l["area"] as NSString
                
                annotation.subtitle = "India"
                
                annotation.title1 = [String(highCount),String(lowCount),String(mediumCount),String(taskUnAssigned)]
                
                
                MyMapView.addAnnotation(annotation)
                annotation = CustomAnnotation()
                
                
            }
            
            
            
        }

        
        //Kormangla
        if (resultsKormangla.count == 0 )
        {
            
            println("no address")
        }
            
        else
        {
            
            lowCount = 0
            highCount = 0
            mediumCount = 0
            taskUnAssigned = 0

            println("In nagwara")
            for l in resultsKormangla
            {
                
                
                var currentpriority: NSString
                
                var a:AnyObject!
                a = l["priority"]
                
                if a == nil
                {
                    println("Nil priority")
                }
                else
                {
                    currentpriority = l["priority"] as String
                    if currentpriority == "High"
                    {
                        
                        highCount++
                    }
                    
                    if currentpriority == "Medium"
                    {
                        mediumCount++
                    }
                    
                    
                    if currentpriority == "Low"
                    {
                        lowCount++
                    }
                    
                }
                
                
                
            }
            
            taskUnAssigned = resultsKormangla.count - (highCount + mediumCount + lowCount)
            
            for l in resultsKormangla
            {
                
                print("IN annotation")
                var lati:CLLocationDegrees = l["latitude"] as CLLocationDegrees!
                var longi:CLLocationDegrees = l["longitude"] as CLLocationDegrees!
                println("my \(lati)")
                println(longi)
                
                var location = CLLocationCoordinate2DMake(lati, longi)
                
                let span = MKCoordinateSpanMake(0.15, 0.15)
                var region = MKCoordinateRegion(center: location, span: span)
                
                MyMapView.setRegion(region, animated: true)
                annotation.setCoordinate(location)
                annotation.title = l["area"] as NSString
                
                annotation.subtitle = "India"
                
                annotation.title1 = [String(highCount),String(lowCount),String(mediumCount),String(taskUnAssigned)]
                
                
                MyMapView.addAnnotation(annotation)
                annotation = CustomAnnotation()
                
                
            }
            
            
            
            
        }

        
        //Banergata
        if (resultsBanerghatta.count == 0 )
        {
            
            println("no address")
        }
            
        else
        {
            
            lowCount = 0
            highCount = 0
            mediumCount = 0
            taskUnAssigned = 0

            for l in resultsBanerghatta
            {
                
                
                var currentpriority: NSString
                
                var a:AnyObject!
                a = l["priority"]
                
                if a == nil
                {
                    println("Nil priority")
                }
                else
                {
                    currentpriority = l["priority"] as String
                    if currentpriority == "High"
                    {
                        
                        highCount++
                    }
                    
                    if currentpriority == "Medium"
                    {
                        mediumCount++
                    }
                    
                    
                    if currentpriority == "Low"
                    {
                        lowCount++
                    }
                    
                }
                
            }
            
            taskUnAssigned = resultsBanerghatta.count - (highCount + mediumCount + lowCount)
            
            for l in resultsBanerghatta
            {
                
                print("IN annotation")
                var lati:CLLocationDegrees = l["latitude"] as CLLocationDegrees!
                var longi:CLLocationDegrees = l["longitude"] as CLLocationDegrees!
                println("my \(lati)")
                println(longi)
                
                var location = CLLocationCoordinate2DMake(lati, longi)
                
                let span = MKCoordinateSpanMake(0.15, 0.15)
                var region = MKCoordinateRegion(center: location, span: span)
                
                MyMapView.setRegion(region, animated: true)
                annotation.setCoordinate(location)
                annotation.title = l["area"] as NSString
                
                annotation.subtitle = "India"
                
                annotation.title1 = [String(highCount),String(lowCount),String(mediumCount),String(taskUnAssigned)]
                
                
                MyMapView.addAnnotation(annotation)
                annotation = CustomAnnotation()
                
                
            }
            
            
        }

        
    }
    
    
    
    
    
        
        





    // ANNOTATION VIEW
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let reuseId = "test"
        
        if !(annotation is CustomAnnotation)
        {
            return nil
        }
        
        
        var tempAnn=annotation as CustomAnnotation
        
        var anView = MyMapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        println("tempann.title1 is \(tempAnn.title1)")
        
        tempAnn.custView1 = CustomCircle(x: -30 , y: -10, width: 200, height: 200, title:tempAnn.title1)
        
        
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            var button = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIButton
            
            for var i:Int = 0;i < areaList.count; i++ {
                
                if areaList[i] == annotation.title {
                    
                    button.tag = i
                    break;
                }
            }
            
            ////////////
            
            button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            anView.rightCalloutAccessoryView = button
            anView.bringSubviewToFront(button)
            
            anView.canShowCallout = true
            
            
            tempAnn.custView1.userInteractionEnabled = true
            
            
            anView.addSubview(tempAnn.custView1)
            
        }
            
        else
        {
            //            for subView in anView.subviews {
            //                subView.removeFromSuperview()
            //            }
            //
            //            anView.addSubview(tempAnn.custView1)
            anView.annotation = annotation
        }
        
        return anView
        
        
    }
    
    
    
    
    
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier=="manager1"
    //        {
    //            let managerTask:ManagerTaskList = segue.destinationViewController as ManagerTaskList
    //            managerTask.delegate = self
    //            println("My high value is \(managerTask.high1)")
    //
    //        }
    //    }
    //
    //    func changeTheCount(high: Int, medium: Int, low: Int) {
    //                highCount = highCount + high
    //                mediumCount = mediumCount + medium
    //                lowCount = lowCount + low
    //    }
    
    
    
    func buttonPressed(sender:UIButton)
    {
        var viewControllerObject:ManagerTaskList = self.storyboard?.instantiateViewControllerWithIdentifier("TVC") as ManagerTaskList
        if (sender.tag == 0)
        {
            
            viewControllerObject.areaName = areaList[0]
            
        }
        else if (sender.tag == 1)
            
        {
            viewControllerObject.areaName = areaList[1]
            
        }
        else if (sender.tag == 2)
        {
            
            viewControllerObject.areaName = areaList[2]
            
        }
        else if (sender.tag == 3)
        {
            
            viewControllerObject.areaName = areaList[3]
            
        }
        self.navigationController?.pushViewController(viewControllerObject, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

