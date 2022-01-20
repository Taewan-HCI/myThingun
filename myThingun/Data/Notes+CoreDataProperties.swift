//
//  Notes+CoreDataProperties.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/20.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var notecontent: String?
    @NSManaged public var notedate: String?
    @NSManaged public var notetime: String?
    @NSManaged public var thingun: Thingun?

}

extension Notes : Identifiable {

}
