//
//  DataService.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import Foundation

class DataService {
    static func getLocalData() -> [ThingunJSON] {
        
        
        
        //get a url path to json file
        let pathString = Bundle.main.path(forResource: "thinguns", ofType:"json")
        
        //check if pathString is not nil, otherwise..
        
        guard pathString != nil else {
            return [ThingunJSON]()
        }
        
        //create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            
            //create a url object
            let data = try Data(contentsOf: url)
            
            // decode the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                
                let thingunData = try decoder.decode([ThingunJSON].self, from: data)
                
                //add unique IDs
                for r in thingunData {
                    r.id = UUID()
                    
                    //add unique IDs to notes
                    for n in r.notes {
                        n.id = UUID()
                    }
                }
                
                //Return the recipe
                return thingunData
                
            }
            catch {
                print(error)
            }
            
        }
        
        catch {
            print(error)
        }
        return [ThingunJSON]()
        
    }
}
