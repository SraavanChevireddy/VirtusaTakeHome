//
//  File.swift
//  
//
//  Created by Sraavan Chevireddy on 22/01/23.
//

import Foundation

protocol DataStore {
    associatedtype StoredType
    
    func store(object: StoredType)
    func fetchObject(_ forKey:String) -> StoredType?
}

class AnyDataStore<StoredType>: DataStore {
    private let storeObject: (StoredType) -> Void
     private let fetchObject: (String) -> StoredType?
    
    init<Store: DataStore>(wrappedStore: Store) where Store.StoredType == StoredType {
       self.storeObject = wrappedStore.store
       self.fetchObject = wrappedStore.fetchObject
     }
    
    /// To store the information related to the matches and teams using Coredata object mapper.
    /// - Parameter object: Typically of type `NSManagedObjectContext`.But supports other objects too.
     func store(object: StoredType) {
       storeObject(object)
     }
    
    /// To return the results of the `NSManagedObjectContext`.
    /// - Parameter forKey: For now, send the `NSFetchRequest`as a `String` to build your own query in the implementation part.
    /// - Returns: Can return  `NSManagedObject`. But, can be overridden where the method is implemented.
     func fetchObject(_ forKey:String) -> StoredType? {
       return fetchObject(forKey)
     }
}
