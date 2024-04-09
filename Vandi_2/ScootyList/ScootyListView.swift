//
//  ScootyListView.swift
//  Vandi_2
//
//  Created by admin49 on 04/04/24.
//

import SwiftUI
struct ScootyListView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    //StatusBar()
                    ScootysListView(viewModel: ExploreViewModel())
                }
                
            }.background(Color.black.opacity(0.1))
        }
    }
}


#Preview {
    ScootyListView()
}
