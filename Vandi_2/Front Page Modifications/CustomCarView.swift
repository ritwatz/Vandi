//
//  SwiftUIView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//

import SwiftUI

struct CustomCarView: View {
    var index: Int
    @StateObject var viewModel: ExploreViewModel
    @State private var isFavorite: Bool
    init(index: Int, viewModel: ExploreViewModel) {
        self.index = index
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.isFavorite = viewModel.VehicleCars[index].isFavorite
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .frame(height: 120)
            .overlay {
                HStack(spacing: 10) {
                    Image(viewModel.VehicleCars[index].mainImageName)
                        .resizable()
                        .frame(width: 80,height: 50)
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.VehicleCars[index].carName)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.orange)
                            Text(String(format: "%.1f", viewModel.VehicleCars[index].rating))
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                        }
                        Text("By \(viewModel.VehicleCars[index].hostName)")
                            .font(.footnote)
                            .foregroundStyle(.mint)
                    }
                    Spacer()
                    Button(action: {
                        isFavorite.toggle()
                    }, label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(.red)
                    })
                    
                }
                .padding()
        }
    }
}

#Preview {
    CustomCarView(index: 0, viewModel: ExploreViewModel())
}
