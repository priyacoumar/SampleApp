//
//  ErrorModel.swift
//  SampleApp
//
//  Created by Swaminathan, Priya on 5/28/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import Foundation

class ErrorModel: NSObject {
   // public private(set) var errorCode: String = ""
    open internal(set) var errorType       : String = ""
    /** The detailed error message associated with this error - should provide specific details about the source of the error*/
    open internal(set) var errorMessage    : String = ""
    /** A URL to help documentation for the error being thrown*/
    open internal(set) var errorHelpURL    : String = ""
    
    internal init(errorType: String, errorMessage: String, errorHelpURL: String) {
        
        self.errorType      = errorType
        self.errorMessage   = errorMessage
        self.errorHelpURL   = errorHelpURL
    }

}
