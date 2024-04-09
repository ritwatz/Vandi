//
//  HomePageTop.swift
//  Vandi_2
//
//  Created by user2 on 02/02/24.
//

import SwiftUI

struct SearchBarListView: View {
    @State private var searchText = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Search Bar with Filter Button
            HStack {
                TextField("Search Vehicle...", text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Spacer()
                
                Button(action: {
                    // Action to perform when filter button is tapped
                    print("Filter button tapped!")
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .clipShape(Circle()).offset(x: 15)
                }
                .padding(.trailing)
            }
            .padding(.horizontal)
            
            // Additional Label and Button
            HStack {
                Text("Popular vehicles near you")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    // Action to perform when "View All" button is tapped
                    print("View All button tapped!")
                }) {
                    Text("View All")
                        .foregroundColor(.teal)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .offset(x: 2,y: 5)
        }
        .padding()
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarListView()
    }
}

#Preview {
    SearchBarListView()
}
