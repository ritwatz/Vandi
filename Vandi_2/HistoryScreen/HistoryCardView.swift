//
//  HistoryCardView.swift
//  Vandi_2
//
//  Created by user2 on 29/02/24.
//

import SwiftUI

struct HistoryCardView: View {
    var carName: String
    var tripDate: String
    var tripStatus: String
    var bookedPrice: Int
    var carRegNo: String

    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(carName)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Date: \(tripDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Status: \(tripStatus)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                VStack {
                    Text("\(bookedPrice)/day")
                        .foregroundStyle(Color.black)
                        
                    Text("\(carRegNo)").bold().offset(y:20)
                }
                
                
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            
        
        }
            
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(carName: "MERCEDES-BENZ C-CLASS", tripDate: "March 1, 2024", tripStatus: "Upcoming", bookedPrice: 4000, carRegNo: "XYZ123")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
