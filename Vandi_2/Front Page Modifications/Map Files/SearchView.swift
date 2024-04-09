//
//  SearchView.swift
//  Vandi_2
//
//  Created by Admin on 26/03/24.
//

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI
//class LocationManager1: NSObject, ObservableObject, CLLocationManagerDelegate {
//    let manager = CLLocationManager()
//
//    @Published var location: CLLocationCoordinate2D?
//
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
//
//    func requestLocation() {
//        manager.requestLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first?.coordinate
//    }
//}
struct SearchView: View {
    @StateObject var locationManager: LocationManager = .init()
    //Mark: Navigation Tag to Push View to MapView
    @State var navigationTag: String?
    @State private var selectedLocation: CLPlacemark? = nil
//    @StateObject var locationManager1 = LocationManager1()
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button{
                    
                } label: {
                    Image(systemName: "chevron.left").font(.title3).foregroundColor(.primary)
                }
                Text("Search Location").font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            HStack(spacing: 10){
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                
                TextField("Find Location Here",text: $locationManager.searchText)
            }
            .padding(.vertical,12)
            .padding(.horizontal)
            .background{
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .strokeBorder(.gray)
            }
            .padding(.vertical,10)
            
            if let places = locationManager.fetchedPlaces,!places.isEmpty{
                List{
                    ForEach(places,id: \.self){place in
                        Button {
                            if let coordinate = place.location?.coordinate{
                                locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                locationManager.addDraggablePin(coordinate: coordinate)
                                locationManager.updatePLacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                
                                //Mark: Navigation to MapView
                                navigationTag = "MAPVIEW"
                            }

                        }label:{
                            HStack(spacing: 15){
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                                VStack(alignment:.leading,spacing: 6){
                                    Text(place.name ?? "")
                                        .font(.title3.bold())
                                        .foregroundColor(.primary)
                                    
                                    Text(place.locality ?? "")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                    }
                }
                .listStyle(.plain)
            }
            else{
                //MARk: Live Location Button
//                VStack {
//                    if let location = locationManager1.location {
//                        Text("Your location: \(location.latitude), \(location.longitude)")
//                    }
//
//                    LocationButton {
//                        locationManager1.requestLocation()
//                    }
//                    .frame(height: 44)
//                    .padding()
//                }
                Button {

                    //Mark: Setting Map Region

                }label: {
                    Label {
                        Text("Use current Location")
                            .font(.callout)
                    } icon:{
                        Image(systemName: "location.north.circle.fill")
                    }
                    .foregroundColor(.green)
                } .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
        .padding()
        .frame(maxHeight: .infinity,alignment: .top)
        .background{
            NavigationLink(tag: "MAPVIEW", selection: $navigationTag){
                MapViewSelection(selectedLocation: $selectedLocation)
                    .environmentObject(locationManager)
                    .navigationBarBackButtonHidden(true)
            } label: {}
                .labelsHidden()
        }
    }
}

struct SearchView_Previews: PreviewProvider{
    static var previews: some View{
        SearchView()
    }
}

//MARK: MapView Live Selection
struct MapViewSelection: View{
    @EnvironmentObject var locationManager: LocationManager
    @Binding var selectedLocation: CLPlacemark?
    @Environment(\.dismiss) var dismiss
    var body: some View{
        ZStack{
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
            
            if let place = locationManager.pickedPlaceMark{
                VStack(spacing: 15){
                    Text("Confirm Location")
                        .font(.title2.bold())
                    
                    HStack(spacing: 15){
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        VStack(alignment:.leading,spacing: 6){
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            
                            Text(place.locality ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }.frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.vertical,10)
                    Button {
                        if let coordinate = place.location?.coordinate {
                            convertToPlacemark(coordinate: coordinate) { placemark in
                                selectedLocation = placemark // Update selectedLocation with chosen location placemark
                            }
                        }
                    }label: {
                        Text("Confirm Location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,100)
                            .background{
                                RoundedRectangle(cornerRadius: 10,style: .continuous).fill(.green)
                            }
                            .overlay(alignment: .trailing){
                                Image(systemName: "arrow.right")
                                    .font(.title3.bold())
                                    .padding(.trailing)
                            }
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
                }
                .frame(maxHeight: .infinity ,alignment: .bottom)
                .ignoresSafeArea()
            }
        }
        .onDisappear{
            locationManager.pickedLocation = nil
            locationManager.pickedPlaceMark = nil
            
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)

        }
    }
}

func convertToPlacemark(coordinate: CLLocationCoordinate2D, completion: @escaping (CLPlacemark?) -> Void) {
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        guard error == nil else {
            print("Reverse geocoding error: \(error!.localizedDescription)")
            completion(nil)
            return
        }
        
        if let placemark = placemarks?.first {
            completion(placemark)
        } else {
            print("No placemark found for the coordinate: \(coordinate)")
            completion(nil)
        }
    }
}
//MARK: UIKit MapView
struct MapViewHelper:UIViewRepresentable{
    @EnvironmentObject var locationManager: LocationManager
    func makeUIView(context: Context) -> MKMapView{
        return locationManager.mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context){
        
    }
}

