//
//  Thingun.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/19.
//

import Foundation

class ThingunJSON: Identifiable, Decodable {
    
    var id:UUID?
    var content:String
    var featured:Bool
    var image:String
    var description:String
    var author:String
    var date:String
    var notes:[NotesJSON]
}

class NotesJSON: Identifiable, Decodable {
    var id:UUID?
    var notecontent:String?
    var notedate:String?
    var notetime:String?
}
