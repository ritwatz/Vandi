//
//  FirebaseFunctions.swift
//  Vandi_2
//
//  Created by admin49 on 04/04/24.
//

import SwiftUI
import Firebase

struct FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {}
    
    // Function to add vehicle data to Firestore
    func addVehicleData(vehicle: VehicleCar) {
        let db = Firestore.firestore()
        let vehicleRef = db.collection("vehicles").document()
        
        // Convert VehicleCar object to dictionary
        let vehicleData: [String: Any] = [
            "id": vehicleRef.documentID,
            "carName": vehicle.carName,
            "rating": vehicle.rating,
            "brand": vehicle.brand,
            "pricePerDay": vehicle.pricePerDay,
            "description": vehicle.description,
            "mainImageName": vehicle.mainImageName,
            "imagesNames": vehicle.imagesNames,
            "insurance": vehicle.insurance,
            "maxDistance": vehicle.maxDistance as Any,
            "numberOfSeats": vehicle.numberOfSeats,
            "numberOfDoors": vehicle.numberOfDoors,
            "GasType": vehicle.GasType,
            // Add other fields as needed
            "pricePerHour": vehicle.pricePerHour,
         //   "reviewsCount": vehicle.reviewsCount,
            "airCondition": vehicle.airCondition,
            "colour": vehicle.colour,
            "milage": vehicle.milage,
            "lastServiceDate": vehicle.lastServiceDate,
            "vendorId": vehicle.vendorId,
            "maxSpeed": vehicle.maxSpeed,
            "horsePower": vehicle.horsePower,
            "distanceAway": vehicle.distanceAway,
           // "govRegistrationNumber": vehicle.govRegistrationNumber,
            "modelName": vehicle.modelName,
            "modelYear": vehicle.modelYear,
            "city": vehicle.city,
            "vehicleType": vehicle.vehicleType,
            "transmissionType": vehicle.transmissionType
        ]
        
        // Add vehicle data to Firestore
        vehicleRef.setData(vehicleData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Vehicle data added with ID: \(vehicleRef.documentID)")
            }
        }
    }
}

// Usage:
// Call this function to add vehicle data to Firestore
// FirebaseManager.shared.addVehicleData(vehicle: yourVehicleObject)

