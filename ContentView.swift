//
//  ContentView.swift
//  Vandi_2
//
//  Created by admin49 on 26/03/24.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                HomePage()
            } else {
                loginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
