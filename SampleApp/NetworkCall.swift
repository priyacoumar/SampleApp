//
//  Network.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/23/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation
class NetworkCall : NSObject {

    static func requestFromURL(_ url: URL, httpMethod: String, httpBody: Data?, httpHeaderFields: Dictionary<String, String>) -> URLRequest
        
        
        
    {
        let defaultTimeout = 60.0
        
        var request: URLRequest = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: defaultTimeout) as URLRequest
        
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        
        let keys = httpHeaderFields.keys
        for key: String in keys
        {
            request.setValue((httpHeaderFields[key]), forHTTPHeaderField: key)
        }
        
        return request
    }
    
    static func sendHTTPSRequest(urlRequest:URLRequest?, onSuccess:@escaping (_ :() -> Any) -> Void, onFailure: @escaping(_ statusError: ErrorModel) -> Void)  -> Void {
        let session = URLSession.shared
      //  let session1 = URLSession(configuration: URLSessionConfiguration.default)
        
        
        let task = session.dataTask(with: urlRequest!, completionHandler: {
            
            (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                if(error == nil && data != nil)
                {
                    //THIS IS THE ACTUAL RESPONSE OBJECT - SERIALIZED JSON DATA
                    let responseObject : Any? = parseJSON(data: data!, onFailure: onFailure)
                    
                    if let dict = responseObject as? NSDictionary {
                        
                        
                        /*There are Currently THREE known error response objects returned from a successful call to a service:
                         - accessToken header errors
                         {
                         code = 401;
                         message = "Invalid/Missing Client ID.";
                         status = failure;
                         }
                         
                         - general header errors
                         {
                           "fault": {
                             "faultstring": "Invalid Access Token",
                             "detail": {
                               "errorcode": "keymanagement.service.invalid_access_token"
                             }
                           }
                         }
                         
                         - general body errors
                         {
                           "requestId": "",
                           "errors": [
                             {
                               "message": "We are sorry, we are unable to complete this request at this time",
                               "helpUrl": "",
                               "type": "SPD-SYS-COM-11037"
                             }
                           ]
                         }
                         
                         - internal SDK Generated errors
                         */
                        
                        if let status = dict["status"] as! String? {
                            if status == "failure" {
                                
                                let errType = dict["code"] as! String
                                let errText = dict["message"] as! String
                                let errMessage = errType + " " + errText
                                
                                let myError = ErrorModel(errorType: errType, errorMessage: errMessage, errorHelpURL: "")
                                //myError.errorMessage = errMessage
                                
                                
                                onFailure(myError)
                                return
                            }
                        }
                        
                        if let fault : Dictionary<String, Any> = dict.object(forKey: "fault") as? Dictionary {
                            let errorDetails : Dictionary<String, Any> = fault["detail"] as! Dictionary
                            let errorCode = errorDetails["errorcode"] as! String
                            let errText = fault["faultstring"] as! String
                            let errMessage = errorCode + " " + errText
                            
                            let myError = ErrorModel(errorType: errorCode, errorMessage: errMessage, errorHelpURL: "")
                            
                            onFailure(myError)
                            return
                        }
                        
                        if let errors : [Dictionary<String, Any>] = dict.object(forKey: "errors") as? Array {
                            
                            let topError = errors.first
                            
                            let errType = topError?["type"] as! String
                            let errMessage = topError?["message"] as! String
                            let errURL = topError?["helpUrl"] as! String
                            
                            let message = errType + " " + errMessage
                            
                            let myError = ErrorModel(errorType: errType, errorMessage: errMessage, errorHelpURL: errURL)
                            
                            onFailure(myError)
                            return
                        }
                        
                        
                    } else if let arr = responseObject as? NSArray {
                        //ARSDebug.debugLog(message: arr)
                    }
                    
                    //THIS CALLS BACK TO THE getResponse CLOSURE THAT WAS PASSED AS A PARAMETER
                    onSuccess(_: { return responseObject! } )
                }
                else
                {
                    if(error == nil)
                    {
                        //Didnt get an error, but have NO DATA
                         let myError = ErrorModel(errorType: "Network Error", errorMessage: "No Data", errorHelpURL: "")
                        
                        
                        onFailure(myError)
                    }
                    else
                    {
                        //Recieved an error
                        let myError = ErrorModel(errorType: "Network", errorMessage: "Error in network call", errorHelpURL: "")
                        onFailure(myError )
                    }
                }
            })
            
        })
        
        task.resume()
    }
    
    internal static func parseJSON(data: Data, onFailure:@escaping(_ statusError: ErrorModel) -> Void) -> Any? {
        var parsedObject : Any?
        
        do {
            parsedObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            let myError = ErrorModel(errorType: "Parse Error", errorMessage: "Error in the Parse Function", errorHelpURL: "")
            onFailure(myError)
        }
        
        return parsedObject
    }
    internal static func formatURLForRequest(endpoint: String) throws -> Foundation.URL {
        
        let urlString =  endpoint
        
        let URL = Foundation.URL(string: urlString)
        // return the compiled URL
        
        //Validate that the compiled object is not nil (we didn't enter invalid characters)
        if URL == nil {
            
            let error = "Failure" //ARSError(errorType: .ARSNetwork_invalid_endpoint)
            
            throw (error as NSString) as! Error
        }
        
        return URL!
    }
}
