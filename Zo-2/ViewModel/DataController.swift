//
//  DataController.swift
//  Zo-2
//
//  Created by Brian Heralall on 3/4/22.
//

import Foundation
import SwiftUI
import CoreData

class DataController: NSObject, ObservableObject {
    
    let container = NSPersistentCloudKitContainer(name: "DataModel")
    
    override init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error)")
            }
        }
        
    }
}

let shareDefault = UserDefaults(suiteName: "group.zoapp")!
