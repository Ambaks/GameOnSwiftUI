//
//  GameOnSwiftUIApp.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 11/06/2024.
//

import SwiftUI
import Firebase

@main
struct GameOnSwiftUIApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            MapView()
                .environmentObject(viewModel)
        }
    }
}
