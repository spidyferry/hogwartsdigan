//
//  AlphabetTable+CoreDataProperties.swift
//  AR2ndTest
//
//  Created by ferry sugianto on 22/07/21.
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

}

extension AlphabetTable : Identifiable {

}
