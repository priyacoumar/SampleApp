//
//  HelperClass.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/23/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation

class HelperClass : NSObject {

        
    // public static func CallWebservice(onSuccess:@escaping (_ responseObj: AccessTokenModel) -> Void, onFailure: @escaping(_ statusError: ErrorModel) -> Void)
        
    public static func CallWebservice(txt: String, onSuccess:@escaping (_ responseObj : AccessTokenModel) -> Void, onFailure: @escaping(_ statusError: ErrorModel) -> Void)
        
      {

        let onSuccessCall = {(responseObj: () -> Any) -> Void in
            let models = responseObj()
            let response =  AccessTokenModel(dictionary: models as! NSDictionary)
            onSuccess(response!)
            print("inside call Webservice Helper Class")
            
        }
        
        let onFailureCall = { (statusError: ErrorModel) -> Void in

            onFailure(statusError)
        }
    
        let urlString = "https://mobile-sgglext-dv.allstate.com/auth/oauth/v2/token"
        var URL : URL
        
        do {
            URL = Foundation.URL(string: urlString)!
            
            let headerDict=["Authorization":"Basic c3lzLXNnLWR2LUNTSU46QVJTbWIzb24ldW1lcg==",
                            "Content-Type":"application/x-www-form-urlencoded"]
            
            let body: String = "grant_type=client_credentials"
            
            let httpBody: Data? = body.data(using: String.Encoding.utf8)
            //let httpBody: Data? = body.data(using: String.Encoding.utf8)
            let myrequest = NetworkCall.requestFromURL(URL,httpMethod: "POST",httpBody: httpBody, httpHeaderFields: headerDict)
            NetworkCall.sendHTTPSRequest(urlRequest: myrequest,
                                         onSuccess: onSuccessCall
                                        ,onFailure: onFailureCall)
        }
        catch
        {
            print("Catch Block")
        }
        
    }
    
//    static func CallWebservice_noInput(onSuccess:@escaping (_ :() -> Any) -> Void, onFailure: @escaping(_ statusError: ErrorModel) -> Void) -> Void
//    {
//         onSuccess({return "Success"})
//         //onFailure("Failure")
//    }
//    static func CallWebservice_Closure(onSucces: @escaping(_ status:String)->Void, onFailure: @escaping(_ FailureStatus: ErrorModel) ->Void)->Void
//    {
//        
//    }
    
    
    static func createHttpBody(_ httpBody: Dictionary<String, String>) -> Data {
        
        var myData : Data?
        
        do {
            try myData = JSONSerialization.data(withJSONObject: httpBody, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
        }
        
        return myData!
    }
}
