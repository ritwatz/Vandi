import SwiftUI
import MapKit

struct ExploreView: View {
    @State private var searchText: String = ""
    private var widthSearchBar: CGFloat = UIScreen.main.bounds.width - 30
    @StateObject var viewModel: ExploreViewModel
    @ObservedObject var citySelectionManager: CitySelectionManager
    @State private var selectedLocation: CLPlacemark?
    @State private var isMenuOpen = false // Track menu visibility
    @State var isMenuBackgroundVisible:Double = 0 // Track menu background visibility

    init(viewModel: ExploreViewModel, citySelectionManager: CitySelectionManager) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.citySelectionManager = citySelectionManager
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    ZStack {
                        GradientColorBackground()
                        VStack {
                            Spacer().frame(height: 85)
                            HStack {
                                // Hamburger menu button
                                Button(action: {
                                    withAnimation {
                                        isMenuOpen.toggle()
                                        isMenuBackgroundVisible = 0.9
                                    }
                                }) {
                                    Circle()
                                        .fill(.white.opacity(0.1))
                                        .frame(width:45,height: 45)
                                        .overlay {
                                            Image(systemName: "bell.badge")
                                            .foregroundStyle(.white)}
                                }
                                Spacer().frame(width: 15)
                                // Location details
                                NavigationLink(destination: SearchView()) {
                                    HStack(spacing: 5){
                                        Image(systemName: "mappin.and.ellipse")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                        HStack(spacing: 6){
                                            Text(selectedLocation?.name ?? "SRM")
                                                .font(.title2.bold())
                                                .foregroundColor(.white)
                                            Text(selectedLocation?.locality ?? "University")
                                                .font(.title2.bold())
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                .padding(.trailing, 10)
                            }
                            CustomSearchBar()
                            Spacer().frame(height: 0)
                            VehicleTypes(viewModel: viewModel)
                            TopVehiclesView(viewModel: viewModel, citySelectionManager: citySelectionManager)
                            Spacer().frame(height: 50)
                        }
                    }
                }
                .navigationStackModifier()
            }
        }
        .overlay(
            // Hamburger menu content
            
            Group {
                if isMenuOpen {
                    ZStack {
                        Color.gray.opacity(Double(isMenuBackgroundVisible)) // Change opacity based on isMenuBackgroundVisible state
                            .frame(maxHeight: .infinity)
                            .ignoresSafeArea(.all)

                        HamburgerMenu()
                            .background(Color.white)
                            .offset(x: -80)
                            .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Check drag direction
                                    if value.translation.width < -50 {
                                        withAnimation {
                                            isMenuOpen = false
                                        }
                                    }
                                }
                        )
                    }
                    .transition(.move(edge: .leading)) // Add transition
                    .animation(.easeInOut) // Add animation
                }
                
            }
        )
    }
}

// Your existing code...
struct NotificationModel {
    let title: String
    let message: String
}

struct HamburgerMenu: View {
    let notifications: [NotificationModel] = [
        NotificationModel(title: "Your OTP is 123456", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
        NotificationModel(title: "New Offer!", message: "Get 20% off on your next purchase."),
        // Add more notifications as needed
    ]
    
    var body: some View {
        // Hamburger menu content...
        VStack{
            Text("Notifications")
                .font(.system(size: 30))
                .fontWeight(.bold).offset(x:-5)
            VStack(spacing: 20) {

                
                // Generate random notifications
                VStack(alignment:.leading){
                    ForEach(notifications, id: \.title) { notification in
                        NotificationView(notification: notification).padding(.vertical,4).offset(x:10)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: 300, maxHeight: .infinity)
        .offset(y:-200)
    }
}

struct NotificationView: View {
    let notification: NotificationModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(notification.title)
                .font(.headline)
            
            Text(notification.message)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView_Previews4: PreviewProvider {
    static var previews: some View {
        ExploreView(viewModel: ExploreViewModel(), citySelectionManager: CitySelectionManager())
            .environmentObject(CitySelectionManager()) // If needed for the environment object
    }
}


struct GradientColorBackground: View {
    var body: some View {
        VStack {
            LinearGradient(colors: [Color(.systemGray),.mint], startPoint: .top, endPoint: .center)
                .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height / 2.18)
            Spacer()
        }
    }
}
