//
//  ContentView.swift
//  14_BucketList
//
//  Created by Vladislav on 01.06.2026.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    var mapStyle: MapStyle {
        switch viewModel.mapMode {
        case .standard: .standard
        case .hybrid: .hybrid
        case .imagery: .imagery
        }
    }
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
                .toolbar {
                    Menu("Mode", systemImage: "map"){
                        Picker("Mode", selection: $viewModel.mapMode) {
                            ForEach(ViewModel.MapMode.allCases) { mode in
                                Text(mode.rawValue)
                            }
                        }
                        .labelsHidden()
                    }
                }
            }
        } else {
            Button("Unlock Places") {
                Task {
                    await viewModel.authenticate()
                }
            }
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            .alert(viewModel.authenticationErrorTitle, isPresented: $viewModel.showingAuthenticationErrorAlert) {
                Button("Try again") {
                    Task {
                        await viewModel.authenticate()
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text(viewModel.authenticationErrorMessage)
            }
        }
    }
}

#Preview {
    ContentView()
}
