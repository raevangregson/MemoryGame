//
//  CoreDataStack_MDF2.swift
//  CustomCoreDataStack
//
//  Created by Raevan Gregson on 2/21/17.
//  Copyright © 2017 Raevan Gregson. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack_MDF2 {

    let context: NSManagedObjectContext!
    let persistentStoreCoordinator: NSPersistentStoreCoordinator!
    let objModel: NSManagedObjectModel!
    let store: NSPersistentStore?
    
    init(){
        let XcDataModelUrl = Bundle.main.url(forResource: "CE7Model", withExtension: "momd")
    
        objModel = NSManagedObjectModel(contentsOf: XcDataModelUrl!)
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objModel)
        context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        let directories:[NSURL] = FileManager.default.urls(for: .documentDirectory, in: . userDomainMask) as [NSURL]
        
        let storeUrl = directories[0].appendingPathComponent("Memory_Data")
        
        let storeOptions = [NSMigratePersistentStoresAutomaticallyOption: true]
        
        do {
            store = try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: storeOptions)
        }
    }
    
    func saveContext(){
    
        if context.hasChanges{
        
            do{
                try context.save()
            }
            catch{
                let nserror = error as NSError
                NSLog("Unresolved error\(error),\(nserror).userInfo)")
                abort()
            }
        }
        
        
    }
}
