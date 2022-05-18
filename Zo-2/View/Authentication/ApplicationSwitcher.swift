//
//  ApplicationSwitcher.swift
//  Zo-2
//
//  Created by Brian Heralall on 5/16/22.
//

import SwiftUI

@main
struct LoginFlowApp: App {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if (vm.isLoggedIn) {
                HomeView()
        } else {
            LogInView(loggedIn: vm.isLoggedIn)
        }
        
    }
}
