//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Foundation

enum requestType : String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum responseCode:Int{
    case ok = 200
    case badRequest  = 400
    case noUserSession = 401
    case notFound = 404
    case internalError = 500
}
