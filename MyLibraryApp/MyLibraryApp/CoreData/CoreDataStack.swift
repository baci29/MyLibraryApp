//
//  CoreDataStack.swift
//  MyLibraryApp
//
//  Created by Radovan Bačík on 12.04.2025.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LibraryModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Nepodařilo se načíst Core Data stack: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
