//
//  HistoryView.swift
//  Vandi_2
//
//  Created by user2 on 29/02/24.
//
import SwiftUI

struct HistoryView: View {
    @State private var selectedTab: HistoryTab = .upcoming

    enum HistoryTab: String {
        case upcoming = "Upcoming"
        case completed = "Completed"
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("History Tab", selection: $selectedTab) {
                    Text("Upcoming").tag(HistoryTab.upcoming)
                    Text("Completed").tag(HistoryTab.completed)
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.mint.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.mint.opacity(1), lineWidth: 1))
                .padding()

                Spacer()

                switch selectedTab {
                case .upcoming:
                    UpcomingTripsView()
                case .completed:
                    CompletedTripsView()
                }
            }
            .navigationTitle("Trip History")
        }
    }
}


struct UpcomingTripsView: View {
    

    var body: some View {
        ScrollView{
            VStack {
                ForEach(upcomingData) { trip in
                    NavigationLink(destination: History_detail_upcoming()){
                        HistoryCardView(carName: trip.carName, tripDate: trip.bookedDate, tripStatus: trip.status, bookedPrice: trip.pricePerDay, carRegNo: trip.govRegistraionNumber)
                    }
                        
                }.padding(.vertical, 4)
                    .padding(.horizontal)
            }
        }
    }
}

struct CompletedTripsView: View {
    

    var body: some View {
        ScrollView{
            VStack {
                ForEach(completedData) { trip in
                    NavigationLink(destination: History_detail_completed()) {
                        HistoryCardView(carName: trip.carName, tripDate: trip.bookedDate, tripStatus: trip.status, bookedPrice: trip.pricePerDay, carRegNo: trip.govRegistraionNumber)
                    }
                        
                }.padding(.vertical, 4)
                    .padding(.horizontal)
            }
        }
    }
}




struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
        }
    }
}
