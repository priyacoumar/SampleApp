//
//  Registration.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/26/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation

//{
//    "appId": "1073",
//    "clientId": "4650",
//    "channelID" : "CH1036",
//    "color": "Redd",
//    "firstName": "JACdQUELYN",
//    "lastName": "BENNEdTT",
//    "mobileNumber": "2248304000",
//    "partnerCode": "M46",
//    "vin": "WMWZC5C58FWT38056"
//}

public class Registration : NSObject {
    public private(set) var clientId : String = ""
    public private(set) var vehicleId : String = ""
    public private(set) var registrationDict :NSDictionary
    
    internal  init(dictionary: NSDictionary) {
        
        self.vehicleId = dictionary["vehicleId"] as! String
        self.clientId = dictionary["clientId"] as! String
        self.registrationDict = dictionary
    }
    
}
