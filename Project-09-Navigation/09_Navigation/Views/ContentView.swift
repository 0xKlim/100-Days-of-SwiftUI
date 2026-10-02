//
//  ContentView.swift
//  09_Navigation
//
//  Created by Vladislav on 29.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, pathStore: pathStore)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, pathStore: pathStore)
                }
        }
    }
}

struct DetailView: View {
    var number: Int
    let pathStore: PathStore
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
                    pathStore.path = NavigationPath()
                }
            }
    }
}

#Preview {
    ContentView()
}
