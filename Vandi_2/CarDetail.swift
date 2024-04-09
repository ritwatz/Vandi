//
//  CarDetail.swift
//  Vandi_2
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct CarDetails: View {
    @State private var isRideNowPressed: Bool = false

    var carName: String
    var carRating: Double
    var reviewsCount: Int
    var carImages: [String]

    @State private var currentIndex = 0

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        NavigationLink(destination: PaymentScreen(), isActive: $isRideNowPressed) {
                            EmptyView()
                        }
                        Button(action: {
                            // Handle back button action
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(Color.black)
                                .padding()
                                .background(Color.clear)
                                .cornerRadius(10)
                                .offset(x: -10)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    Text(carName)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .padding(.top, 5)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", carRating))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                        Text("(\(reviewsCount) reviews)")
                            .font(.caption)
                            .foregroundColor(Color.black)
                    }

                    ImageSlider(images: carImages)
                        .padding(-8)

                    Text("Specifications")
                        .font(.title2)
                        .padding(.bottom, 4)

                    HStack(spacing: 12) {
                        SpecificationCard(icon: "power", title: "Max Power", info: "300 hp")
                        SpecificationCard(icon: "speedometer", title: "Max Speed", info: "200 km/h")
                        SpecificationCard(icon: "drop", title: "Mileage", info: "15 km/l")
                        SpecificationCard(icon: "stopwatch", title: "0 to 60", info: "5.2s")
                    }
                    .padding(8)

                    Text("Car Features")
                        .font(.title2)
                        .padding(.bottom, 4)

                    VStack(alignment: .leading, spacing: 7) {
                        FeatureCard(title: "Model", info: "XYZ123")
                        FeatureCard(title: "Fuel Type", info: "Petrol")
                        FeatureCard(title: "Transmission", info: "Automatic")
                        FeatureCard(title: "Color", info: "Blue")
                        FeatureCard(title: "Air Condition", info: "Yes")
                    }
                    .padding(1)
                }
                .padding()

                HStack(spacing: 0) {
                    NavigationLink(destination: PaymentScreen(), isActive: $isRideNowPressed) {
                        Button(action: {
                            // Handle Book Later action
                        }) {
                            Text("Book Later")
                                .foregroundColor(Color(hex: "00ADB5"))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color(hex: "00ADB5"), lineWidth: 1))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Button(action: {
                        isRideNowPressed.toggle()
                    }) {
                        Text("Ride Now")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(hex: "00ADB5"))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(8)
            }
            .background(Color(.systemBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CarDetails_Previews: PreviewProvider {
    static var previews: some View {
        CarDetails(carName: "Tesla Model S", carRating: 4.5, reviewsCount: 50, carImages: ["car1", "car2", "car3"])
    }
}

struct ImageSlider: View {
    var images: [String]
    @State private var currentIndex = 0

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(16/9, contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 2/5)
            .padding()
        }
    }
}


struct SpecificationCard: View {
    var icon: String
    var title: String
    var info: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(Color.black)
            Text(title)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color.black)
            Text(info)
                .font(.system(size: 10))
                .foregroundColor(Color.black)
        }
        .padding(8)
        .frame(width: 80, height: 80)
        .background(Color(hex: "00ADB5"))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
    }
}

struct FeatureCard: View {
    var title: String
    var info: String

    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            Spacer()
            Text(info)
                .font(.body)
                .foregroundColor(Color.black)
        }
        .padding(8)
        .background(Color(hex: "00ADB5"))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}
