//
//  vehicleCarCard.swift
//  Vandi_2
//
//  Created by admin49 on 30/03/24.
//

import SwiftUI

struct vehicleCarCardView: View {

    var vehicleName: String
    var description: String
    var vendorId: String
    var imageURL: String
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .clipped()
                    .frame(width: 85, height: 85)
                    .cornerRadius(50)
                    .padding(.trailing, 5)
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .clipped()
                    .frame(width: 85, height: 85)
                    .cornerRadius(50)
                    .padding(.trailing, 5)
            }
            .frame(width: 90, height: 90)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(vehicleName)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text(description)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                
                Text("By \(vendorId)")
                    .font(.footnote)
                    .foregroundColor(.mint)
            }
            Spacer()
        }
        .padding()
    }
}

struct vehicleCarCardView_Previews: PreviewProvider {
    static var previews: some View {
        vehicleCarCardView(vehicleName: "Vehicle Name", description: "Description", vendorId: "Vendor ID", imageURL: "Image URL")
    }
}




                                 //                    Button(action: {
                                 //                        isFavorite.toggle()
                                 //                        // Update the vehicle's favorite status in the ViewModel or wherever it is stored
                                 //                        vehicleViewModel.vehicleData[index].bookingConfirmed = isFavorite ? 1 : 0
                                 //                    }, label: {
                                 //                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                 //                            .foregroundColor(.red)
                                 //                    })
