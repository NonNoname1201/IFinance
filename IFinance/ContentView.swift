//
//  ContentView.swift
//  IFinance
//
//  Created by student on 09/06/2024.
//

import SwiftUI
import CoreData



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
