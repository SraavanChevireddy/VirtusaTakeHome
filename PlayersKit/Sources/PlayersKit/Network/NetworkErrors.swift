//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Foundation

enum loginErr : Error {
    case invalidInput
    case sessionExpired
    case unableToGetResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidInput:
            return  NSLocalizedString("Username and Password are invalid", comment: "loginError")
        case .sessionExpired:
            return  NSLocalizedString("Session Expired. Login again from Auth", comment: "loginError")
        case .unableToGetResponse:
            return  NSLocalizedString("Unable to get the response", comment: "loginError")
        }
    }
}
