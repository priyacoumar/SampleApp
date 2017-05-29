//
//  SimpleNetwork.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/27/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation
class SimpleNetwork : NSObject {
    static func makeGetCall() ->Void {
        // Set up the URL request
        //let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        let todoEndpoint: String = "https://mobile-sgglext-dv.allstate.com/auth/oauth/v2/token"
        
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
       
        let body: String = "grant_type=client_credentials"
        let httpBody: Data? = body.data(using: String.Encoding.utf8)
        
        urlRequest.httpBody = httpBody
        
        urlRequest.setValue("Basic c3lzLXNnLWR2LUNTSU46QVJTbWIzb24ldW1lcg==", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        
        // set up the session
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        
        task.resume()
    }
}

