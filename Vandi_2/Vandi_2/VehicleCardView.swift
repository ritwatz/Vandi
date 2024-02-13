import SwiftUI

// Struct to represent the vehicle type
struct VehicleType: Identifiable {
    var id: UUID = UUID()
    var name: String
    var emoji: String
}

// Your main view
struct SelectTransportView: View {
    // List of vehicle types
    let vehicleTypes = [
        VehicleType(name: "Car", emoji: "🚗"),
        VehicleType(name: "Bike", emoji: "🏍️"),
        VehicleType(name: "Scooty", emoji: "🛵")
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Heading with back button
                HStack {
                    // NavigationLink(destination: /* Your back button action here */) {
                    //     Image(systemName: "arrow.left")
                    //         .padding()
                    // }
                    Spacer()
                    Text("Select Transport")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                
                
                // Cards for Car and Bike
                VStack(spacing: 20){
                    HStack(spacing: 8) {
                        CardView(vehicleType: vehicleTypes[0])
                            .frame(width: 100, height: 150) // Adjust the size as needed
                        CardView(vehicleType: vehicleTypes[1])
                            .frame(width: 100, height: 150) // Adjust the size as needed
                    }
                    .padding()
                    
                    // Vertical spacing above Scooty
                    
                    
                    // Card for Scooty below Car and Bike
                    ZStack {
                        CardView(vehicleType: vehicleTypes[2])
                            .frame(width: 100, height: 150) // Adjust the size as needed
                            .offset(y: -30) // Adjust the offset as needed
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

// CardView to represent each vehicle type card
struct CardView: View {
    var vehicleType: VehicleType

    var body: some View {
        VStack {
            Text(vehicleType.emoji)
                .font(.system(size: 30)) // Adjust the font size as needed
                .padding()
            Text(vehicleType.name)
                .font(.caption) // Adjust the font size as needed
                .fontWeight(.bold)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color(red: 0.678, green: 0.847, blue: 0.902)) // Light teal background
        .cornerRadius(15)
    }
}

struct SelectTransportView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTransportView()
    }
}
