//
//  TowServiceHelper.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/26/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation

public class TowServiceHelper: NSObject{
    static func getTowService(_ request:String, onSuccess: @escaping(_ response:Registration) -> Void, onFailure:@escaping( _ statusError:ErrorModel) ->Void)->Void
    {
        let onSuccessCall = { (responseObj : () -> Any)-> Void in
            
            let models = responseObj()
            let response =  Registration(dictionary: models as! NSDictionary)
            onSuccess(response)
            print("inside call Webservice Helper Class")
        }
        
        let urlString = "https://mobile-sgglext-dv.allstate.com/mobile/MobileApps/ARS/Mobile_Consumer/registerCustomer"
        var URL : URL
        
        do {
            URL = try NetworkCall.formatURLForRequest(endpoint: urlString)
            let headerDict=["Authorization":"Basic c3lzLXNnLWR2LUNTSU46QVJTbWIzb24ldW1lcg==",
                            "Content-Type":"application/x-www-form-urlencoded"]
            
            //  var httpBody: Data
            // httpBody = createHttpBody(dict)
            
            let body: String = "grant_type=client_credentials"
            
            let httpBody: Data? = body.data(using: String.Encoding.utf8)
            let myrequest = NetworkCall.requestFromURL(URL,httpMethod: "POST",httpBody: httpBody, httpHeaderFields: headerDict)
            NetworkCall.sendHTTPSRequest(urlRequest: myrequest,
                                         onSuccess: onSuccessCall ,
                                         onFailure: onFailure)
        }
        catch
        {
            print("Catch Block")
        }

    }
    
}
