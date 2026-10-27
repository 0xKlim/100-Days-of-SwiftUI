//
//  ContentView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 25.05.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    UserRowView(name: user.name, isActive: user.isActive)
                }
            }
            .navigationTitle("Friend Face")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button("Refresh", systemImage: "arrow.clockwise") {
                        Task {
                            await loadData()
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user, path: $path) { id in
                    users.first { $0.id == id }
                }
            }
        }
        .task {
            if users.isEmpty {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        let urlPath =  "https://www.hackingwithswift.com/samples/friendface.json"
        
        if let url = URL(string: urlPath) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                decodeData(data)
            } catch {
                print("Error! \(error.localizedDescription)")
            }
        } else {
            print("URL ERROR")
        }
    }
    
    func decodeData(_ data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode([User].self, from: data)
            users = decoded
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Failed to decode from bundle due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            print("Failed to decode from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Failed to decode from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            print("Failed to decode from bundle because it appears to be invalid JSON.")
        } catch {
            print("Failed to decode from bundle: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
