//
//  AccessTokenModel.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/26/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation

public class AccessTokenModel: NSObject {
    public private(set) var access_token : String
    public private(set) var expires_in : Double
    
    public private(set) var accessTokenDict : NSDictionary
            
    internal  init?(dictionary: NSDictionary)  {
        
        self.expires_in  = (dictionary["expires_in"] as? Double)!
        self.access_token = (dictionary["access_token"]as? String)!
        
        accessTokenDict = dictionary
    }
}
