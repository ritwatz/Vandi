//
//  HistoryStruct.swift
//  Vandi_2
//
//  Created by user2 on 29/02/24.
//

import Foundation

struct HistoryStruct: Codable, Identifiable, Hashable {
    var id = UUID()  // Unique identifier

    let govRegistraionNumber: String
    var carName: String
    var pricePerDay: Int
    var bookedDate: String
    var status: String
}
