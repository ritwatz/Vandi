//
//  ListingItemView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct ListingItemView: View {
    var images = [
        "mercedes_c_0",
        "mercedes_c_1",
        "mercedes_c_2",
    ]
    
    var body: some View {
        VStack{
            //images
            TabView{
                ForEach(images,id: \.self ) { image in
                    Image(image)
                        .resizable()
//                        .scaledToFit()
                }
            }
            .frame(height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .tabViewStyle(.page)
            //listing details
            HStack(alignment: .top){
                //details
                VStack(alignment: .leading){
                    Text("BMW")
                        .fontWeight(.semibold)
                    Text("12 miles away")
                        .foregroundStyle(.gray)
                    Text("March 25-30")
                        .foregroundStyle(.gray)
                    HStack(spacing: 4){
                        Text("₹4500")
                            .fontWeight(.semibold)
                        Text("per Day")
                    }
                    HStack(spacing: 4){
                        Text("₹500")
                            .fontWeight(.semibold)
                        Text("per Hour")
                    }
                }
                //rating
                Spacer()
                
                HStack(spacing: 4){
                    Image(systemName: "star.fill")
                    Text("4.9")
                    
                }
            }
            .font(.footnote)
        }
    }
}

#Preview {
    ListingItemView()
}
