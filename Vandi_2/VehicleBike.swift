//
//  VehicleBike.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import Foundation

struct VehicleBike: Identifiable,Codable,Hashable {
    
    let id: String
    let bikeName: String
    var rating: Double
    let brand: String
    var pricePerDay: Int
    var description: String
    var mainImageName: String
    var imagesNames: [String]
    //var insurance: String
    var maxDistance: Float?
//    var numberOfSeats: Int
//    var numberOfDoors: Int
    var GasType: String
    var hostName: String
    var hostImageName: String
    var hostJoinDate: String
    var isFavorite: Bool
}
