//
//  VehicleType.swift
//  Vandi_2
//
//  Created by Admin on 26/03/24.
//

import Foundation

struct Brand: Identifiable,Hashable,Codable {
    
    let id: String
    let brandName: String
    let imageName: String
    var carIds: [String]
    
}
struct VehicleT: Identifiable,Hashable,Codable {
    let id: String
    let Name: String
    let imageName: String
}
