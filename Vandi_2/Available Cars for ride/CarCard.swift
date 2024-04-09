//
//  CardView.swift
//  Vandi_2
//
//  Created by user2 on 26/02/24.
//

import SwiftUI

struct CarCard: View {
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 10) {
                    // Details (left side)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Car Model Name")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Text("Automatic | Seats: 4")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Image(systemName: "location")
                                .foregroundColor(.tealAccent)
                            Text("800m (5 mins away)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    // Image (right side)
                    Image(systemName: "car.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(10)
                 // Add border
                
                // Buttons
                HStack(spacing: 10) {
                    // Rate per Day button
                    Button(action: {
                        // Handle rate per day button action here
                    }) {
                        Text("Rate per Day")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.tealAccent)
                            .cornerRadius(10)
                    }
                    Spacer()
                    // Rate per Hour button
                    Button(action: {
                        // Handle rate per hour button action here
                    }) {
                        Text("Rate per Hour")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.tealAccent)
                            .cornerRadius(10)
                    }
                }
                 // Add some space above the buttons
                .padding(.horizontal, 10) // Add padding to buttons for better spacing
            }
            .padding(10)
            .background(Color.tealCardBackground)
            .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
        }.padding(10)
    }
}

extension Color {
    static let tealAccent = Color(red: 0, green: 0.5, blue: 0.5)
    static let tealCardBackground = Color(red: 0.7, green: 0.9, blue: 0.9)
}

struct CarCard_Previews: PreviewProvider {
    static var previews: some View {
        CarCard()
    }
}

