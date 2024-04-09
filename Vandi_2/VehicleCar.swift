//
//  VehicleCar.swift
//  Vandi_2
//
//  Created by user2 on 27/02/24.
//

import Foundation


struct VehicleCar: Identifiable,Codable,Hashable {
    
    let id: String
    let carName: String
    var rating: Double
    let brand: String
    var pricePerDay: Int
    var description: String
    var mainImageName: String
    var imagesNames: [String]
    var insurance: String
    var maxDistance: Float?
    var numberOfSeats: Int
    var numberOfDoors: Int
    var GasType: String
    var hostName: String
    var hostImageName: String
    var hostJoinDate: String
    var isFavorite: Bool
    //Added data structure
    var pricePerHour: Int
    var reviewscount: Int
    var airCondition: Bool
    var colour: String
    var milage: Double
    var lastServiceDate: Date
    var vendorId : Int
    var maxSpeed : Double
    var horsePower : Double
    var distanceAway: Double
    var govRegistraionNumber: String
    var modelName: String
    var modelYear: String
    var city: String
    var vehicleType: String
    var transmissionType: String
}
