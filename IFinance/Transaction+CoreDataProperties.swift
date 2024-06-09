//
//  Transaction+CoreDataProperties.swift
//  IFinance
//
//  Created by student on 09/06/2024.
//
//

import Foundation
import CoreData
import SwiftUI


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Double
    @NSManaged public var type: String?
    @NSManaged public var timestamp: Date?

}

extension Transaction : Identifiable {

}
