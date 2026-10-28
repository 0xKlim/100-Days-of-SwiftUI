//
//  ContentView.swift
//  -05_Consolidation_Friendface
//
//  Created by Vladislav on 25.05.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder: [SortDescriptor<User>] = [SortDescriptor(\.name)]
    @State private var usersFilter: UserFilter = .all
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            UserListView(filter: usersFilter ,sort: sortOrder)
            .navigationTitle("Friend Face")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Picker("Filter", selection: $usersFilter) {
                        ForEach(UserFilter.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name (A-Z)")
                                .tag([
                                    SortDescriptor<User>(\.name)
                                ])
                            Text("Name (Z-A)")
                                .tag([
                                    SortDescriptor<User>(\.name, order: .reverse)
                                ])
                        }
                    }
                }
                ToolbarItem(placement: .primaryAction){
                    Button("Refresh", systemImage: "arrow.clockwise") {
                        updateData(container: modelContext.container)
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user, path: $path) { id in
                    var descriptor = FetchDescriptor<User>(predicate: #Predicate {
                        $0.id == id
                    })
                    descriptor.fetchLimit = 1
                    return try? modelContext.fetch(descriptor).first
                }
            }
        }
        .task {
            updateData(container: modelContext.container)
        }
    }
    
    func updateData(container: ModelContainer) {
        Task.detached(priority: .background) {
            guard let loadedData = await loadData() else { return }
            guard let users = decodeData(loadedData) else { return }
            
            let backgroundContext = ModelContext(container)
            backgroundContext.autosaveEnabled = false
            
            users.forEach { backgroundContext.insert($0) }
            
            do {
                try backgroundContext.save()
            } catch {
                print("BD Error! \(error.localizedDescription)")
            }
        }
    }
    
    func loadData() async -> Data? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print("Error! \(error.localizedDescription)")
        }
        return nil
    }
    
    nonisolated func decodeData(_ data: Data) -> [User]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            return try decoder.decode([User].self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Failed to decode due to missing key '\(key.stringValue)' – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            print("Failed to decode due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Failed to decode due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            print("Failed to decode because it appears to be invalid JSON.")
        } catch {
            print("Failed to decode: \(error.localizedDescription)")
        }
        return nil
    }
}


#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
