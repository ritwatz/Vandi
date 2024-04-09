//
//  vehiclecard.swift
//  Vandi_2
//
//  Created by admin49 on 29/03/24.
//

import SwiftUI

struct vehiclecard: View {
    var carName : String
    var model : String
    var body: some View {
        Text(carName)
        Text(model)
    }
}

#Preview {
    vehiclecard(carName: "carn", model: "model")
}
