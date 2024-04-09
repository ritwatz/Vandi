//
//  CarList.swift
//  Vandi_2
//
//  Created by user2 on 26/02/24.
//

import SwiftUI

struct CarList: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Back button
//                    HStack {
//                        NavigationLink(destination: AnotherPage()) {
//                            Image(systemName: "chevron.left")
//                                .font(.title)
//                                .foregroundColor(.black)
//                        }
//                        Spacer() // Add space to push the button to the leading edge
//                    }
//                    .padding(.horizontal)

                    // Headline
                    Text("Available cars for ride")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.horizontal)

                    // HStack for "18 searches found" and filter button
                    HStack {
                        // Subtitle
                        Text("18 searches found")
                            .font(.subheadline)
                            .foregroundColor(.tealColor)

                        Spacer() // Add space to push the following content to the right

                        // Filter button
                        Button(action: {
                            // Handle filter button action here
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.tealColor)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)

                    // Add your list of cars or additional content here
                    VStack(spacing: 10) {
                        ForEach(0..<5) { _ in
                            CarCard()
                                .padding(.top, 1) // Adjust top padding to position CarCard below CarList
                        }
                            
                        
                    }

                }
                .navigationBarHidden(true) // Hide the default navigation bar
                .padding(.top) // Add padding to fix CarList to the top
                .padding(.horizontal) // Hide the default navigation bar
            }
        }
    }
}

//struct AnotherPage: View {
//    var body: some View {
//        Text("Another Page")
//            .font(.largeTitle)
//            .padding()
//    }
//}

extension Color {
    static let tealColor = Color(red: 0, green: 0.5, blue: 0.5) // You can adjust the values for the desired teal color
}

struct CarList_Previews: PreviewProvider {
    static var previews: some View {
        CarList()
    }
}
