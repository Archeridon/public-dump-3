//
//  ViewController.swift
//  Diwy Bikes
//
//  Created by Student on 10/10/16.
//  Copyright © 2016 Archeridon. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var fillerLat = 41.5702
    var fillerLong = -87.6425
    
    var bikes = [[String: String]]()
    var trueLat = [[String: String]]()
    var realLat = [String]()
    var realLog = [String]()
    
    var indexLat = Int()
    var indexLog = Int()
    var location = [String]()
    var latplace = [String]()
    var longPlace = [String]()
    
    var x = -1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        logsAndLat()
        
        let urlString = "http://www.divvybikes.com/stations/json/"
        
        if let url = NSURL(string: urlString)
        {
            if let myData = try? NSData(contentsOfURL: url, options: [])
            {
                let json = JSON(data : myData)
                    print("ok to parse")
                    parse(json)
                
            }
        }
       
           }
    ///End SuperView
    func parse(json: JSON)
    {
        for result in json["stationBeanList"].arrayValue
        {
            let availibleBikes = result["availableBikes"].stringValue
            let totalDocks = result["totalDocks"].stringValue
            let location = result["stationName"].stringValue
            let address = result["stAddress1"].stringValue
            let latitude = result["latitude"].stringValue
            let longitude = result["longitude"].stringValue
            
            let docking = ["location": location, "address": address, "totalDocks": totalDocks , "availibleBikes": availibleBikes, "latitude": latitude, "longitude": longitude]
            //print("\(location)")
            
            bikes.append(docking)
            
            
        }
        tableView.reloadData()
    }

    
   
    func logsAndLat(){
        let n = 41.88327159253
        let latmax = Int((n + 0.000019825) * 1000000)
        let latmin = Int((n - 0.000019825) * 1000000)
        
        let m = 81
        let logmax = Int((n + 0.000009825) * 1000000)
        let logmin = Int((n - 0.000009825) * 1000000)
        
        
        
        let endLat = ["latitude"]
        let endLatitude = endLat.map{ NSString(string: $0).doubleValue }
        
        let endLog = ["longitude"]
        let endLongitude = endLog.map{ NSString(string: $0).doubleValue }
        
        print("\(endLat)")
       
        var doubleLog = endLongitude.map { $0 * 1000000}
        var testLog = doubleLog.map { Int($0)}
        print("\(testLog)")
        
        var doubleLat = endLatitude.map {$0 * 1000000}
        var testLat = doubleLat.map { Int($0)}
        //print("\(YouTried)")
        
        location = ["location"]
        let asshole = ["kill me"]
        
        
        for testLat in latmin...latmax
        {
            let localLat = String((Double(testLat)/1000000))
            print("\(localLat) butt")
            self.realLat.append(localLat)
            //indexLat = endLat.indexOf("\(localLat)")!
            //latplace.append(location[indexLat])
            
            
        }
      print("\(realLat)")
      print("\(latplace)")
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realLat.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        x = x + 1
        
        if x >= 42{
            //stops it from crashing....
        }
        else{
        cell.textLabel!.text = "\(realLat[x])"
        }
        
        //cell.textLabel!.text = bike["location"]
       // cell.detailTextLabel?.text = "\(bike["availibleBikes"]!) Bikes availible"
        return cell
    }
    


}

