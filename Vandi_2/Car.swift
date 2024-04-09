//
//  VehicleCar.swift
//  Vandi_2
//
//  Created by user2 on 27/02/24.
//

import Foundation


struct Car: Identifiable,Codable,Hashable {
    
    var id: UUID = UUID()
    let govRegistraionNumber: String
    let carName: String
    var carRating: Double
    var reviewsCount: Int
    let brand: String
    var modelName: String
    var modelYear: String
    var pricePerDay: Int
    var pricePerHour: Int
    var description: String
    var mainImageName: String
    var imagesNames: [String]
    var insurance: String
    var maxDistance: Float?
    var numberOfSeats: Int
    var numberOfDoors: Int
    var transmissionType: String
    var GasType: String
    var hostName: String
    var HostImageName: String
    var HostJoinDate: String
    var isFavorite: Bool
    var airCondition: Bool
    var colour: String
    var milage: Double
    var lastServiceDate: Date?
    var vendorId : Int
    var maxSpeed : Double
    var horsePower : Double
    var distanceAway: Double?
}

func countNumberOfCars(cars: [Car]) -> Int {
    return cars.count
}

// Example usage:
let numberOfCars : Int = countNumberOfCars(cars: cars)

