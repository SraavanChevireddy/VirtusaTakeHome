//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 20/01/23.
//

import Foundation

public protocol GameRepository: AnyObject {
    func validateTeamsInformation()
    func validateMatchesInformation()
}
