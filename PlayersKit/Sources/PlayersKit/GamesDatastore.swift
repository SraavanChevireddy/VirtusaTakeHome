//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 22/01/23.
//

import Foundation
import CoreData

class GamesDataStore: DataStore {
    typealias StoredType = NSManagedObjectContext
    
    /// Saves the information related to Matches in the database.
    /// - Parameter object: Send the object that has to be saved to Coredata. For now only a single entry is available
    func store(object: NSManagedObjectContext) {
        
    }
    
    /// To fetch the information related to Games
    /// - Parameter forKey: Build the query and send as `String`
    /// - Returns: The `NSManagedObject` as results.
    func fetchObject(_ forKey: String) -> NSManagedObjectContext? {
            return nil
    }
}

class StoreManager {
    func gameDataStore() -> AnyDataStore<NSManagedObjectContext>{
        let gameMemoryDatastore = GamesDataStore()
        return AnyDataStore(wrappedStore: gameMemoryDatastore)
    }
}
