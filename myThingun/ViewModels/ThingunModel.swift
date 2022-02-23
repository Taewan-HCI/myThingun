//
//  ThingunModel.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import Foundation
import SwiftUI
import UIKit

class ThingunModel: ObservableObject {
    
    //reference to the managed object context
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var thinguns = [Thingun]()
    
    init() {
        
        // check if we have pre loaded the data into core data
        checkLoadedData()
        
        
    }
    
    func deletePost(thingun: Thingun) throws{
        self.managedObjectContext.delete(thingun)
        try self.managedObjectContext.save()
    }
    
    func checkLoadedData() {
        
        //check local storage for the flag
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
        // if it doesn't exist, then we should parse local json and preload the core data
        if status == false {
            preloadLocalData()
        }
        
        
    }
    
    
    func preloadLocalData() {
        
        // parse the local JSON file
        let localThingun = DataService.getLocalData()
        
        // create core data object
        for t in localThingun {
            
            //create a core data object
            let thingun = Thingun(context: managedObjectContext)
            //set its property
            thingun.content = t.content
            thingun.author = t.author
            thingun.featured = t.featured
            thingun.id = UUID()
            thingun.image = UIImage(named: t.image)?.jpegData(compressionQuality: 1.0)
            thingun.summary = t.description
            thingun.date = t.date
            
            //set the ingredients
            for i in t.notes {
                
                //create a coredata
                let notes = Notes(context: managedObjectContext)
                notes.id = UUID()
                notes.notecontent = i.notecontent
                notes.notedate = i.notedate
                notes.notetime = i.notetime
                
                //add this ingredient to the recipe
                thingun.addToNotes(notes)
                
            }
            
        }
        
        
        // save into core data
        
        do {
            try managedObjectContext.save()
            
            //set local storage flag
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        }
        catch {
            print(error)
        }
        
        
        // set local stroa
    }
    
}
