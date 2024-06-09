//
//  Transaction+CoreDataProperties.swift
//  IFinance
//
//  Created by student on 09/06/2024.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var type: String?

}

extension Transaction : Identifiable {

}
