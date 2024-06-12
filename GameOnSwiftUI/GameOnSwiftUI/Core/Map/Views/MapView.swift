//
//  MapView.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 12/06/2024.
//
import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .onAppear{
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .mapControls{
                MapCompass()
                MapPitchToggle()
                MapUserLocationButton()
                
                    }
    }
}





#Preview {
    MapView()
}
