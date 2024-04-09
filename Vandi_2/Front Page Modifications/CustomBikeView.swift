import SwiftUI

struct CustomBikeView: View {
    var index: Int
    @StateObject var viewModel: ExploreViewModel
    @State private var isFavorite: Bool
    
    init(index: Int, viewModel: ExploreViewModel) {
        self.index = index
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._isFavorite = State(initialValue: viewModel.VehicleCars[index].isFavorite)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(height: 120)
            .overlay {
                HStack(spacing: 10) {
                    Image(viewModel.VehicleCars[index].mainImageName) // Use VehicleCars instead of VehicleBikes
                        .resizable()
                        .frame(width: 80, height: 50)
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.VehicleCars[index].carName) // Use VehicleCars instead of VehicleBikes
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black)
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color.orange)
                            Text(String(format: "%.1f", viewModel.VehicleCars[index].rating))
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                        }
                        Text("By \(viewModel.VehicleCars[index].hostName)") // Use VehicleCars instead of VehicleBikes
                            .font(.footnote)
                            .foregroundStyle(Color.mint)
                    }
                    Spacer()
                    Button(action: {
                        isFavorite.toggle()
                        viewModel.VehicleCars[index].isFavorite = isFavorite // Update the underlying data
                    }, label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(Color.red)
                    })
                }
                .padding()
            }
    }
}

struct CustomBikeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBikeView(index: 0, viewModel: ExploreViewModel())
    }
}
