//
//  ListView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                SearchAndFilterBar()
                ForEach(0...10,id:\.self){ listing in
                    LazyVStack{
                        ListingItemView()
                            .frame(height:425)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ListView()
}
