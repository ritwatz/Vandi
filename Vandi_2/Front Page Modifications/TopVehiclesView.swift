//
//  TopCarsView.swift
//  Vandi_2
//
//  Created by user2 on 28/02/24.
//
import SwiftUI

class CitySelectionManager: ObservableObject {
    @Published var selectedCity: String?
}

struct TopVehiclesView: View {
    @StateObject var viewModel: ExploreViewModel
    @ObservedObject var citySelectionManager: CitySelectionManager

    init(viewModel: ExploreViewModel, citySelectionManager: CitySelectionManager) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.citySelectionManager = citySelectionManager
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Popular Vehicles")
                .font(.headline)
                .fontWeight(.semibold)

            if let selectedCity = citySelectionManager.selectedCity, !selectedCity.isEmpty {
                // Filter vehicles based on selected city
                let filteredVehicles = viewModel.VehicleCars.filter { $0.city == selectedCity }
                ForEach(filteredVehicles) { car in
                    let index = viewModel.VehicleCars.firstIndex(where: { $0 == car }) ?? 0
                    NavigationLink {
                        DetailCarView(viewModel: viewModel, index: index)
                            .navigationBarBackButtonHidden()
                    } label: {
                        CustomCarView(index: index, viewModel: viewModel)
                    }
                }
            } else {
                // Show all vehicles
                ForEach(viewModel.VehicleCars) { car in
                    let index = viewModel.VehicleCars.firstIndex(where: { $0 == car }) ?? 0
                    NavigationLink {
                        DetailCarView(viewModel: viewModel, index: index)
                            .navigationBarBackButtonHidden()
                    } label: {
                        CustomCarView(index: index, viewModel: viewModel)
                    }
                }
            }
        }
        .padding()
    }
}





struct ContentView_Previews3: PreviewProvider {
    static var previews: some View {
        let citySelectionManager = CitySelectionManager()
        let exploreViewModel = ExploreViewModel()

        return TopVehiclesView(viewModel: exploreViewModel, citySelectionManager: citySelectionManager)
            .environmentObject(citySelectionManager)
            .environmentObject(exploreViewModel)
    }
}
