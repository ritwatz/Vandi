//
//  Vandi_2App.swift
//  Vandi_2
//
//  Created by user2 on 02/02/24.
//

import SwiftUI
import Firebase

@main
struct Vandi_2App: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject private var citySelectionManager = CitySelectionManager()
    @StateObject private var exploreViewModel = ExploreViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(viewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
