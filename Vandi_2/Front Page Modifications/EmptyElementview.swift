//
//  EmptyElementview.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct EmptyElementView: View {
    var imageName: String
    var title: String
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 30,height: 200)
                .scaledToFill()
            Text(title)
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    EmptyElementView(imageName: "", title: "")
}
