//
//  AlphabetTable+CoreDataProperties.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 25/07/21.
//
//

import Foundation
import CoreData


extension AlphabetTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlphabetTable> {
        return NSFetchRequest<AlphabetTable>(entityName: "AlphabetTable")
    }

    @NSManaged public var alphabet: String?
    @NSManaged public var date: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var alphabetRec: String?
    @NSManaged public var wordRec: String?

}

extension AlphabetTable : Identifiable {

}
