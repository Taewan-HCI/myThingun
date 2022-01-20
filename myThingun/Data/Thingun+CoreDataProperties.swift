//
//  Thingun+CoreDataProperties.swift
//  myThingun
//
//  Created by Taewan Kim on 2022/01/20.
//
//

import Foundation
import CoreData


extension Thingun {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thingun> {
        return NSFetchRequest<Thingun>(entityName: "Thingun")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var content: String
    @NSManaged public var featured: Bool
    @NSManaged public var image: Data?
    @NSManaged public var summary: String
    @NSManaged public var author: String
    @NSManaged public var date: String
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension Thingun {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Notes)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Notes)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension Thingun : Identifiable {

}
