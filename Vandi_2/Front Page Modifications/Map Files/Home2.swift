//
//  Home2.swift
//  Vandi_2
//
//  Created by Admin on 26/03/24.
//

import SwiftUI
import MapKit
import CoreLocation
struct Home2: View {
    /// Map Properties
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @State private var mapSelection: MKMapItem?
    @Namespace private var locationSpace
    @State private var viewingRegion: MKCoordinateRegion?
    /// Search Properties
    @State private var searchtext: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    ///Map Selection Detail Properties
    @State private var showDetails: Bool = true
    @State private var lookAroundScene: MKLookAroundScene?
    ///Map Selection Detail Properties
    @State private var routeDisplaying: Bool = true
    @State private var route: MKRoute?
    @State private var routeDestination: MKPlacemark?
    let location1 = CLLocationCoordinate2D.myLocation
    let location2 = CLLocationCoordinate2D.finalDestination
    
    
    // Define your predefined final location
    let finalDestination = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
                /// Map Annotations and Route Display
//                Annotation("Apple Park", coordinate: .myLocation) {
//                    ZStack {
//                        Image(systemName: "applelogo")
//                            .font(.title3)
//                        Image(systemName: "square")
//                            .font(.largeTitle)
//                    }
//                }.annotationTitles(.hidden)
                Marker("Your Car is Here",coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
                
                // Display Route to Predefined Final Destination
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 7)
                }
                
                // To show the User Current Location
                UserAnnotation()
            }
            .sheet(isPresented: $showDetails, onDismiss:{
                withAnimation(.snappy){
                    ///Zooming Region
                    if let boundingRect = route?.polyline.boundingMapRect, routeDisplaying {
                        cameraPosition = .rect(boundingRect)
                    }
                }
            }, content:{
                MapDetails()
                .presentationDetents ([.height(150)])
                .presentationBackgroundInteraction (.enabled(upThrough:.height(150)))
                .presentationCornerRadius(25)
                .interactiveDismissDisabled(true)
            })
            .safeAreaInset(edge: .bottom){
                if routeDisplaying{
                    Button("End Route"){
                        ///Closing the Rote and setteing the selection
                        withAnimation(.snappy){
                            routeDisplaying = false
                            showDetails = true
                            routeDestination = nil
                            route = nil
                            cameraPosition = .region(.myRegion)
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth:.infinity)
                    .padding(.vertical, 12)
                    .background(.red.gradient,in: .rect(cornerRadius:15 ))
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
//            .onAppear {
//                fetchRouteToFinalDestination()
//            }
         
        }
        .mapScope(locationSpace)
        .navigationTitle("Maps")
        .navigationBarTitleDisplayMode(.large)
    }
    
    /// Fetching Route to Predefined Final Destination
    func fetchRouteToFinalDestination() {
        let request = MKDirections.Request()
        request.source = .init(placemark: .init(coordinate: .myLocation))
        request.destination = .init(placemark: .init(coordinate: .finalDestination))
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            routeDestination = finalDestination
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else { return }
            }
            
            withAnimation(.snappy) {
                routeDisplaying = true
                showDetails = false
            }
        }
    }
    
    func midpointCoordinate(location1: CLLocationCoordinate2D, location2: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let midLatitude = (location1.latitude + location2.latitude) / 2
        let midLongitude = (location1.longitude + location2.longitude) / 2
        return CLLocationCoordinate2D(latitude: midLatitude, longitude: midLongitude)
    }
    
    func MapDetails() -> some View {
        VStack() {
//            ZStack{
//                /// New look Around Api
//                if lookAroundScene == nil {
//                    ///New Empty View Api
//                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
//                } else{
//                    LookAroundPreview(scene: $lookAroundScene)
//                }
//            }.frame(height: 200)
//             .clipShape(.rect (cornerRadius: 15))
//             .overlay(alignment: .topTrailing){
//                 Button(action: {
//                 /// Closing View
//                 showDetails = false
//                     withAnimation(.snappy) {
//                         mapSelection = nil
//                     }
//                 }, label: {
//                 Image (systemName: "xmark.circle.fill")
//                 .font(.title)
//                 .foregroundStyle(.black)
//                 .background(.white, in: .circle)
//                 })
//                 .padding (10)
//             }
             /// Direction's Button
            Button("Get Directions",action:fetchRouteToFinalDestination)
             .foregroundStyle (.white)
             .frame(maxWidth: .infinity)
             .padding(.vertical, 20)
             .background(.blue.gradient, in: .rect(cornerRadius: 15))
        }
        .padding(15)
    }
    
}


//// Location Data
//extension CLLocationCoordinate2D {
//    static var myLocation: CLLocationCoordinate2D {
//        return .init(latitude: 37.3346, longitude: -122.0090)
//    }
//}
//
//extension CLLocationCoordinate2D {
//    static var finalDestination: CLLocationCoordinate2D {
//        return .init(latitude: 37.7749, longitude: -122.4194)
//    }
//}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .finalDestination, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home2()
    }
}
